class EnvConfig {
  // TODO: Replace these with your actual Supabase values
  // These should match your .env file values
  static const String supabaseUrl = 'https://tddddqmyqltzvwzoocsd.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkZGRkcW15cWx0enZ3em9vY3NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkwMzcwNzcsImV4cCI6MjA2NDYxMzA3N30.9Fv8JENOgQPDwGJ7kf_8rlUyiR3lz66Pex3ntT2y90w';
  
  // Office Security Settings
  // TODO: Replace with your actual office WiFi and location details
  static const String officeWifiSSID = 'YOUR_OFFICE_WIFI_SSID';
  static const String officeWifiBSSID = 'YOUR_OFFICE_WIFI_BSSID';
  static const double officeLatitude = 0.0;  // Replace with actual latitude
  static const double officeLongitude = 0.0; // Replace with actual longitude
  static const double officeGeofenceRadius = 100.0; // meters
  
  // App Configuration
  static const String appName = 'SunCoopAtt';
  static const bool debugMode = true;
  
  // Time & Date Settings
  static const int defaultBreakTimeMinutes = 30;
  static const int maxShiftHours = 12;
  static const int overtimeThresholdHours = 8;
  
  // Security Settings
  static const bool requireWifiCheck = true;
  static const bool requireGPSCheck = true;
  static const bool requireDeviceIntegrityCheck = true;
  
  // Validation
  static bool get isValidConfig {
    return supabaseUrl.contains('supabase.co') &&
           supabaseAnonKey.isNotEmpty &&
           supabaseAnonKey != 'YOUR_SUPABASE_ANON_KEY_HERE';
  }
  
  static Map<String, dynamic> get configSummary {
    return {
      'supabase_configured': isValidConfig,
      'debug_mode': debugMode,
      'wifi_check_enabled': requireWifiCheck,
      'gps_check_enabled': requireGPSCheck,
      'device_check_enabled': requireDeviceIntegrityCheck,
      'office_location_set': officeLatitude != 0.0 || officeLongitude != 0.0,
    };
  }
} 