// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String? ?? 'staff',
      phone: json['phone'] as String?,
      employeeId: json['employeeId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'role': instance.role,
      'phone': instance.phone,
      'employeeId': instance.employeeId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CreateUserRequestImpl _$$CreateUserRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateUserRequestImpl(
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  password: json['password'] as String,
  phone: json['phone'] as String?,
  employeeId: json['employeeId'] as String?,
  role: json['role'] as String? ?? 'staff',
);

Map<String, dynamic> _$$CreateUserRequestImplToJson(
  _$CreateUserRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'fullName': instance.fullName,
  'password': instance.password,
  'phone': instance.phone,
  'employeeId': instance.employeeId,
  'role': instance.role,
};

_$UpdateUserRequestImpl _$$UpdateUserRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateUserRequestImpl(
  fullName: json['fullName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  phone: json['phone'] as String?,
  employeeId: json['employeeId'] as String?,
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$$UpdateUserRequestImplToJson(
  _$UpdateUserRequestImpl instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'phone': instance.phone,
  'employeeId': instance.employeeId,
  'isActive': instance.isActive,
};
