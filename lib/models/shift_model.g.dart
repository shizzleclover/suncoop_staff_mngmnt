// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftModelImpl _$$ShiftModelImplFromJson(Map<String, dynamic> json) =>
    _$ShiftModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
      maxStaff: (json['maxStaff'] as num?)?.toInt() ?? 1,
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
      createdBy: json['createdBy'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ShiftModelImplToJson(_$ShiftModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'maxStaff': instance.maxStaff,
      'hourlyRate': instance.hourlyRate,
      'createdBy': instance.createdBy,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ShiftWithBookingsImpl _$$ShiftWithBookingsImplFromJson(
  Map<String, dynamic> json,
) => _$ShiftWithBookingsImpl(
  shift: ShiftModel.fromJson(json['shift'] as Map<String, dynamic>),
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => ShiftBookingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  availableSpots: (json['availableSpots'] as num).toInt(),
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$$ShiftWithBookingsImplToJson(
  _$ShiftWithBookingsImpl instance,
) => <String, dynamic>{
  'shift': instance.shift,
  'bookings': instance.bookings,
  'availableSpots': instance.availableSpots,
  'isAvailable': instance.isAvailable,
};

_$ShiftBookingModelImpl _$$ShiftBookingModelImplFromJson(
  Map<String, dynamic> json,
) => _$ShiftBookingModelImpl(
  id: json['id'] as String,
  shiftId: json['shiftId'] as String,
  userId: json['userId'] as String,
  status: json['status'] as String? ?? 'booked',
  bookedAt: DateTime.parse(json['bookedAt'] as String),
  cancelledAt: json['cancelledAt'] == null
      ? null
      : DateTime.parse(json['cancelledAt'] as String),
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ShiftBookingModelImplToJson(
  _$ShiftBookingModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'shiftId': instance.shiftId,
  'userId': instance.userId,
  'status': instance.status,
  'bookedAt': instance.bookedAt.toIso8601String(),
  'cancelledAt': instance.cancelledAt?.toIso8601String(),
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$CreateShiftRequestImpl _$$CreateShiftRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateShiftRequestImpl(
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  location: json['location'] as String?,
  maxStaff: (json['maxStaff'] as num?)?.toInt() ?? 1,
  hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$CreateShiftRequestImplToJson(
  _$CreateShiftRequestImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'location': instance.location,
  'maxStaff': instance.maxStaff,
  'hourlyRate': instance.hourlyRate,
};

_$UpdateShiftRequestImpl _$$UpdateShiftRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateShiftRequestImpl(
  title: json['title'] as String?,
  description: json['description'] as String?,
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  location: json['location'] as String?,
  maxStaff: (json['maxStaff'] as num?)?.toInt(),
  hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$$UpdateShiftRequestImplToJson(
  _$UpdateShiftRequestImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime?.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'location': instance.location,
  'maxStaff': instance.maxStaff,
  'hourlyRate': instance.hourlyRate,
  'isActive': instance.isActive,
};
