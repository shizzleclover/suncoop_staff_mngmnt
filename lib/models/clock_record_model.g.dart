// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClockRecordModelImpl _$$ClockRecordModelImplFromJson(
  Map<String, dynamic> json,
) => _$ClockRecordModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  shiftBookingId: json['shiftBookingId'] as String?,
  clockInTime: DateTime.parse(json['clockInTime'] as String),
  clockOutTime: json['clockOutTime'] == null
      ? null
      : DateTime.parse(json['clockOutTime'] as String),
  clockInWifiSsid: json['clockInWifiSsid'] as String?,
  clockInWifiBssid: json['clockInWifiBssid'] as String?,
  clockInLatitude: (json['clockInLatitude'] as num?)?.toDouble(),
  clockInLongitude: (json['clockInLongitude'] as num?)?.toDouble(),
  clockInDeviceInfo: json['clockInDeviceInfo'] as Map<String, dynamic>?,
  clockOutWifiSsid: json['clockOutWifiSsid'] as String?,
  clockOutWifiBssid: json['clockOutWifiBssid'] as String?,
  clockOutLatitude: (json['clockOutLatitude'] as num?)?.toDouble(),
  clockOutLongitude: (json['clockOutLongitude'] as num?)?.toDouble(),
  clockOutDeviceInfo: json['clockOutDeviceInfo'] as Map<String, dynamic>?,
  totalHours: (json['totalHours'] as num?)?.toDouble(),
  breakTimeMinutes: (json['breakTimeMinutes'] as num?)?.toInt() ?? 0,
  overtimeHours: (json['overtimeHours'] as num?)?.toDouble() ?? 0,
  status: json['status'] as String? ?? 'clocked_in',
  isValid: json['isValid'] as bool? ?? true,
  validationNotes: json['validationNotes'] as String?,
  adminAdjusted: json['adminAdjusted'] as bool? ?? false,
  adminNotes: json['adminNotes'] as String?,
  adjustedBy: json['adjustedBy'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ClockRecordModelImplToJson(
  _$ClockRecordModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'shiftBookingId': instance.shiftBookingId,
  'clockInTime': instance.clockInTime.toIso8601String(),
  'clockOutTime': instance.clockOutTime?.toIso8601String(),
  'clockInWifiSsid': instance.clockInWifiSsid,
  'clockInWifiBssid': instance.clockInWifiBssid,
  'clockInLatitude': instance.clockInLatitude,
  'clockInLongitude': instance.clockInLongitude,
  'clockInDeviceInfo': instance.clockInDeviceInfo,
  'clockOutWifiSsid': instance.clockOutWifiSsid,
  'clockOutWifiBssid': instance.clockOutWifiBssid,
  'clockOutLatitude': instance.clockOutLatitude,
  'clockOutLongitude': instance.clockOutLongitude,
  'clockOutDeviceInfo': instance.clockOutDeviceInfo,
  'totalHours': instance.totalHours,
  'breakTimeMinutes': instance.breakTimeMinutes,
  'overtimeHours': instance.overtimeHours,
  'status': instance.status,
  'isValid': instance.isValid,
  'validationNotes': instance.validationNotes,
  'adminAdjusted': instance.adminAdjusted,
  'adminNotes': instance.adminNotes,
  'adjustedBy': instance.adjustedBy,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$ClockInRequestImpl _$$ClockInRequestImplFromJson(Map<String, dynamic> json) =>
    _$ClockInRequestImpl(
      shiftBookingId: json['shiftBookingId'] as String?,
      wifiSsid: json['wifiSsid'] as String?,
      wifiBssid: json['wifiBssid'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ClockInRequestImplToJson(
  _$ClockInRequestImpl instance,
) => <String, dynamic>{
  'shiftBookingId': instance.shiftBookingId,
  'wifiSsid': instance.wifiSsid,
  'wifiBssid': instance.wifiBssid,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'deviceInfo': instance.deviceInfo,
};

_$ClockOutRequestImpl _$$ClockOutRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ClockOutRequestImpl(
  clockRecordId: json['clockRecordId'] as String,
  wifiSsid: json['wifiSsid'] as String?,
  wifiBssid: json['wifiBssid'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  deviceInfo: json['deviceInfo'] as Map<String, dynamic>?,
  breakTimeMinutes: (json['breakTimeMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ClockOutRequestImplToJson(
  _$ClockOutRequestImpl instance,
) => <String, dynamic>{
  'clockRecordId': instance.clockRecordId,
  'wifiSsid': instance.wifiSsid,
  'wifiBssid': instance.wifiBssid,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'deviceInfo': instance.deviceInfo,
  'breakTimeMinutes': instance.breakTimeMinutes,
};

_$LocationInfoImpl _$$LocationInfoImplFromJson(Map<String, dynamic> json) =>
    _$LocationInfoImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LocationInfoImplToJson(_$LocationInfoImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      deviceId: json['deviceId'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      appVersion: json['appVersion'] as String?,
      isRooted: json['isRooted'] as bool?,
      isEmulator: json['isEmulator'] as bool?,
      fingerprint: json['fingerprint'] as String?,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceModel': instance.deviceModel,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'isRooted': instance.isRooted,
      'isEmulator': instance.isEmulator,
      'fingerprint': instance.fingerprint,
    };

_$WorkSummaryImpl _$$WorkSummaryImplFromJson(Map<String, dynamic> json) =>
    _$WorkSummaryImpl(
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalHours: (json['totalHours'] as num).toDouble(),
      overtimeHours: (json['overtimeHours'] as num).toDouble(),
      totalSessions: (json['totalSessions'] as num).toInt(),
      records: (json['records'] as List<dynamic>)
          .map((e) => ClockRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WorkSummaryImplToJson(_$WorkSummaryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'totalHours': instance.totalHours,
      'overtimeHours': instance.overtimeHours,
      'totalSessions': instance.totalSessions,
      'records': instance.records,
    };
