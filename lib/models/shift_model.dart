import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_model.freezed.dart';
part 'shift_model.g.dart';

@freezed
class ShiftModel with _$ShiftModel {
  const factory ShiftModel({
    required String id,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    @Default(1) int maxStaff,
    double? hourlyRate,
    required String createdBy,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ShiftModel;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);
}

@freezed
class ShiftWithBookings with _$ShiftWithBookings {
  const factory ShiftWithBookings({
    required ShiftModel shift,
    required List<ShiftBookingModel> bookings,
    required int availableSpots,
    required bool isAvailable,
  }) = _ShiftWithBookings;

  factory ShiftWithBookings.fromJson(Map<String, dynamic> json) =>
      _$ShiftWithBookingsFromJson(json);
}

@freezed
class ShiftBookingModel with _$ShiftBookingModel {
  const factory ShiftBookingModel({
    required String id,
    required String shiftId,
    required String userId,
    @Default('booked') String status,
    required DateTime bookedAt,
    DateTime? cancelledAt,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ShiftBookingModel;

  factory ShiftBookingModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftBookingModelFromJson(json);
}

@freezed
class CreateShiftRequest with _$CreateShiftRequest {
  const factory CreateShiftRequest({
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    @Default(1) int maxStaff,
    double? hourlyRate,
  }) = _CreateShiftRequest;

  factory CreateShiftRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateShiftRequestFromJson(json);
}

@freezed
class UpdateShiftRequest with _$UpdateShiftRequest {
  const factory UpdateShiftRequest({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    int? maxStaff,
    double? hourlyRate,
    bool? isActive,
  }) = _UpdateShiftRequest;

  factory UpdateShiftRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateShiftRequestFromJson(json);
} 