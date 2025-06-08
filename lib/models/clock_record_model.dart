import 'package:freezed_annotation/freezed_annotation.dart';

part 'clock_record_model.freezed.dart';
part 'clock_record_model.g.dart';

@freezed
class ClockRecordModel with _$ClockRecordModel {
  const factory ClockRecordModel({
    required String id,
    required String userId,
    String? shiftBookingId,
    required DateTime clockInTime,
    DateTime? clockOutTime,
    
    // Security & Location Data
    String? clockInWifiSsid,
    String? clockInWifiBssid,
    double? clockInLatitude,
    double? clockInLongitude,
    Map<String, dynamic>? clockInDeviceInfo,
    
    String? clockOutWifiSsid,
    String? clockOutWifiBssid,
    double? clockOutLatitude,
    double? clockOutLongitude,
    Map<String, dynamic>? clockOutDeviceInfo,
    
    // Calculated fields
    double? totalHours,
    @Default(0) int breakTimeMinutes,
    @Default(0) double overtimeHours,
    
    // Status and validation
    @Default('clocked_in') String status,
    @Default(true) bool isValid,
    String? validationNotes,
    
    // Admin override
    @Default(false) bool adminAdjusted,
    String? adminNotes,
    String? adjustedBy,
    
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ClockRecordModel;

  factory ClockRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ClockRecordModelFromJson(json);
}

@freezed
class ClockInRequest with _$ClockInRequest {
  const factory ClockInRequest({
    String? shiftBookingId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
  }) = _ClockInRequest;

  factory ClockInRequest.fromJson(Map<String, dynamic> json) =>
      _$ClockInRequestFromJson(json);
}

@freezed
class ClockOutRequest with _$ClockOutRequest {
  const factory ClockOutRequest({
    required String clockRecordId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
    int? breakTimeMinutes,
  }) = _ClockOutRequest;

  factory ClockOutRequest.fromJson(Map<String, dynamic> json) =>
      _$ClockOutRequestFromJson(json);
}

@freezed
class LocationInfo with _$LocationInfo {
  const factory LocationInfo({
    required double latitude,
    required double longitude,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
  }) = _LocationInfo;

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);
}

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    String? deviceId,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    bool? isRooted,
    bool? isEmulator,
    String? fingerprint,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@freezed
class WorkSummary with _$WorkSummary {
  const factory WorkSummary({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required double totalHours,
    required double overtimeHours,
    required int totalSessions,
    required List<ClockRecordModel> records,
  }) = _WorkSummary;

  factory WorkSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkSummaryFromJson(json);
} 