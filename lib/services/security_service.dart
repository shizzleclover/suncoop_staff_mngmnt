import 'package:geolocator/geolocator.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/config/env_config.dart';
import '../models/clock_record_model.dart';

class SecurityService {
  static Future<LocationInfo?> getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return LocationInfo(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        timestamp: position.timestamp,
      );
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }

  static Future<bool> validateLocation(LocationInfo location) async {
    try {
      if (!EnvConfig.requireGPSCheck) {
        return true; // Skip validation if not required
      }

      // Calculate distance from office location
      final distanceInMeters = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        EnvConfig.officeLatitude,
        EnvConfig.officeLongitude,
      );

      return distanceInMeters <= EnvConfig.officeGeofenceRadius;
    } catch (e) {
      throw Exception('Failed to validate location: $e');
    }
  }

  static Future<Map<String, String?>> getWiFiInfo() async {
    try {
      if (!EnvConfig.requireWifiCheck) {
        return {'ssid': 'Not Required', 'bssid': 'Not Required'};
      }

      // Check WiFi permission on Android
      if (await Permission.locationWhenInUse.isDenied) {
        await Permission.locationWhenInUse.request();
      }

      final wifiInfo = WifiInfo();
      final ssid = await wifiInfo.getWifiSSID();
      final bssid = await wifiInfo.getWifiBSSID();

      return {
        'ssid': ssid,
        'bssid': bssid,
      };
    } catch (e) {
      throw Exception('Failed to get WiFi info: $e');
    }
  }

  static Future<bool> validateWiFi(String? ssid, String? bssid) async {
    try {
      if (!EnvConfig.requireWifiCheck) {
        return true; // Skip validation if not required
      }

      // Check SSID match
      if (EnvConfig.officeWifiSSID.isNotEmpty && ssid != null) {
        if (ssid.replaceAll('"', '') == EnvConfig.officeWifiSSID) {
          return true;
        }
      }

      // Check BSSID match (more reliable)
      if (EnvConfig.officeWifiBSSID.isNotEmpty && bssid != null) {
        if (bssid.toLowerCase() == EnvConfig.officeWifiBSSID.toLowerCase()) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw Exception('Failed to validate WiFi: $e');
    }
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return DeviceInfo(
          deviceId: androidInfo.id,
          deviceModel: '${androidInfo.brand} ${androidInfo.model}',
          osVersion: 'Android ${androidInfo.version.release}',
          appVersion: EnvConfig.appName,
          isRooted: androidInfo.isPhysicalDevice == false,
          isEmulator: androidInfo.isPhysicalDevice == false,
          fingerprint: androidInfo.fingerprint,
        );
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return DeviceInfo(
          deviceId: iosInfo.identifierForVendor,
          deviceModel: '${iosInfo.name} ${iosInfo.model}',
          osVersion: 'iOS ${iosInfo.systemVersion}',
          appVersion: EnvConfig.appName,
          isRooted: iosInfo.isPhysicalDevice == false,
          isEmulator: iosInfo.isPhysicalDevice == false,
          fingerprint: iosInfo.identifierForVendor,
        );
      } else {
        return const DeviceInfo(
          deviceId: 'unknown',
          deviceModel: 'Unknown Device',
          osVersion: 'Unknown OS',
          appVersion: 'Unknown',
          isRooted: false,
          isEmulator: false,
          fingerprint: 'unknown',
        );
      }
    } catch (e) {
      throw Exception('Failed to get device info: $e');
    }
  }

  static Future<bool> validateDeviceIntegrity(DeviceInfo deviceInfo) async {
    try {
      if (!EnvConfig.requireDeviceIntegrityCheck) {
        return true; // Skip validation if not required
      }

      // Check if device is rooted/jailbroken
      if (deviceInfo.isRooted == true) {
        return false;
      }

      // Check if running on emulator
      if (deviceInfo.isEmulator == true) {
        return false;
      }

      return true;
    } catch (e) {
      throw Exception('Failed to validate device integrity: $e');
    }
  }

  static Future<Map<String, dynamic>> performSecurityValidation() async {
    try {
      final results = <String, dynamic>{
        'locationValid': false,
        'wifiValid': false,
        'deviceValid': false,
        'location': null,
        'wifiInfo': null,
        'deviceInfo': null,
        'errors': <String>[],
      };

      // Get location
      try {
        final location = await getCurrentLocation();
        if (location != null) {
          results['location'] = location;
          results['locationValid'] = await validateLocation(location);
        }
      } catch (e) {
        results['errors'].add('Location: $e');
      }

      // Get WiFi info
      try {
        final wifiInfo = await getWiFiInfo();
        results['wifiInfo'] = wifiInfo;
        results['wifiValid'] = await validateWiFi(
          wifiInfo['ssid'], 
          wifiInfo['bssid'],
        );
      } catch (e) {
        results['errors'].add('WiFi: $e');
      }

      // Get device info
      try {
        final deviceInfo = await getDeviceInfo();
        results['deviceInfo'] = deviceInfo;
        results['deviceValid'] = await validateDeviceIntegrity(deviceInfo);
      } catch (e) {
        results['errors'].add('Device: $e');
      }

      results['allValid'] = results['locationValid'] && 
                           results['wifiValid'] && 
                           results['deviceValid'];

      return results;
    } catch (e) {
      throw Exception('Failed to perform security validation: $e');
    }
  }

  static String getValidationSummary(Map<String, dynamic> validation) {
    final errors = validation['errors'] as List<String>;
    if (errors.isNotEmpty) {
      return 'Validation failed: ${errors.join(', ')}';
    }

    final List<String> issues = [];
    
    if (!(validation['locationValid'] as bool)) {
      issues.add('Invalid location');
    }
    if (!(validation['wifiValid'] as bool)) {
      issues.add('Invalid WiFi network');
    }
    if (!(validation['deviceValid'] as bool)) {
      issues.add('Device integrity check failed');
    }

    if (issues.isEmpty) {
      return 'All security checks passed';
    } else {
      return 'Issues: ${issues.join(', ')}';
    }
  }
}

// Platform detection (you may need to import 'dart:io')
import 'dart:io' show Platform; 