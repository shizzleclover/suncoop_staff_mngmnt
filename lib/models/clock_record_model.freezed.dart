// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clock_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClockRecordModel _$ClockRecordModelFromJson(Map<String, dynamic> json) {
  return _ClockRecordModel.fromJson(json);
}

/// @nodoc
mixin _$ClockRecordModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get shiftBookingId => throw _privateConstructorUsedError;
  DateTime get clockInTime => throw _privateConstructorUsedError;
  DateTime? get clockOutTime =>
      throw _privateConstructorUsedError; // Security & Location Data
  String? get clockInWifiSsid => throw _privateConstructorUsedError;
  String? get clockInWifiBssid => throw _privateConstructorUsedError;
  double? get clockInLatitude => throw _privateConstructorUsedError;
  double? get clockInLongitude => throw _privateConstructorUsedError;
  Map<String, dynamic>? get clockInDeviceInfo =>
      throw _privateConstructorUsedError;
  String? get clockOutWifiSsid => throw _privateConstructorUsedError;
  String? get clockOutWifiBssid => throw _privateConstructorUsedError;
  double? get clockOutLatitude => throw _privateConstructorUsedError;
  double? get clockOutLongitude => throw _privateConstructorUsedError;
  Map<String, dynamic>? get clockOutDeviceInfo =>
      throw _privateConstructorUsedError; // Calculated fields
  double? get totalHours => throw _privateConstructorUsedError;
  int get breakTimeMinutes => throw _privateConstructorUsedError;
  double get overtimeHours =>
      throw _privateConstructorUsedError; // Status and validation
  String get status => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  String? get validationNotes =>
      throw _privateConstructorUsedError; // Admin override
  bool get adminAdjusted => throw _privateConstructorUsedError;
  String? get adminNotes => throw _privateConstructorUsedError;
  String? get adjustedBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ClockRecordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClockRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClockRecordModelCopyWith<ClockRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClockRecordModelCopyWith<$Res> {
  factory $ClockRecordModelCopyWith(
    ClockRecordModel value,
    $Res Function(ClockRecordModel) then,
  ) = _$ClockRecordModelCopyWithImpl<$Res, ClockRecordModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? shiftBookingId,
    DateTime clockInTime,
    DateTime? clockOutTime,
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
    double? totalHours,
    int breakTimeMinutes,
    double overtimeHours,
    String status,
    bool isValid,
    String? validationNotes,
    bool adminAdjusted,
    String? adminNotes,
    String? adjustedBy,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ClockRecordModelCopyWithImpl<$Res, $Val extends ClockRecordModel>
    implements $ClockRecordModelCopyWith<$Res> {
  _$ClockRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClockRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? shiftBookingId = freezed,
    Object? clockInTime = null,
    Object? clockOutTime = freezed,
    Object? clockInWifiSsid = freezed,
    Object? clockInWifiBssid = freezed,
    Object? clockInLatitude = freezed,
    Object? clockInLongitude = freezed,
    Object? clockInDeviceInfo = freezed,
    Object? clockOutWifiSsid = freezed,
    Object? clockOutWifiBssid = freezed,
    Object? clockOutLatitude = freezed,
    Object? clockOutLongitude = freezed,
    Object? clockOutDeviceInfo = freezed,
    Object? totalHours = freezed,
    Object? breakTimeMinutes = null,
    Object? overtimeHours = null,
    Object? status = null,
    Object? isValid = null,
    Object? validationNotes = freezed,
    Object? adminAdjusted = null,
    Object? adminNotes = freezed,
    Object? adjustedBy = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            shiftBookingId: freezed == shiftBookingId
                ? _value.shiftBookingId
                : shiftBookingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockInTime: null == clockInTime
                ? _value.clockInTime
                : clockInTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            clockOutTime: freezed == clockOutTime
                ? _value.clockOutTime
                : clockOutTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            clockInWifiSsid: freezed == clockInWifiSsid
                ? _value.clockInWifiSsid
                : clockInWifiSsid // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockInWifiBssid: freezed == clockInWifiBssid
                ? _value.clockInWifiBssid
                : clockInWifiBssid // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockInLatitude: freezed == clockInLatitude
                ? _value.clockInLatitude
                : clockInLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            clockInLongitude: freezed == clockInLongitude
                ? _value.clockInLongitude
                : clockInLongitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            clockInDeviceInfo: freezed == clockInDeviceInfo
                ? _value.clockInDeviceInfo
                : clockInDeviceInfo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            clockOutWifiSsid: freezed == clockOutWifiSsid
                ? _value.clockOutWifiSsid
                : clockOutWifiSsid // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockOutWifiBssid: freezed == clockOutWifiBssid
                ? _value.clockOutWifiBssid
                : clockOutWifiBssid // ignore: cast_nullable_to_non_nullable
                      as String?,
            clockOutLatitude: freezed == clockOutLatitude
                ? _value.clockOutLatitude
                : clockOutLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            clockOutLongitude: freezed == clockOutLongitude
                ? _value.clockOutLongitude
                : clockOutLongitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            clockOutDeviceInfo: freezed == clockOutDeviceInfo
                ? _value.clockOutDeviceInfo
                : clockOutDeviceInfo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            totalHours: freezed == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                      as double?,
            breakTimeMinutes: null == breakTimeMinutes
                ? _value.breakTimeMinutes
                : breakTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            overtimeHours: null == overtimeHours
                ? _value.overtimeHours
                : overtimeHours // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            isValid: null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            validationNotes: freezed == validationNotes
                ? _value.validationNotes
                : validationNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            adminAdjusted: null == adminAdjusted
                ? _value.adminAdjusted
                : adminAdjusted // ignore: cast_nullable_to_non_nullable
                      as bool,
            adminNotes: freezed == adminNotes
                ? _value.adminNotes
                : adminNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            adjustedBy: freezed == adjustedBy
                ? _value.adjustedBy
                : adjustedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClockRecordModelImplCopyWith<$Res>
    implements $ClockRecordModelCopyWith<$Res> {
  factory _$$ClockRecordModelImplCopyWith(
    _$ClockRecordModelImpl value,
    $Res Function(_$ClockRecordModelImpl) then,
  ) = __$$ClockRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? shiftBookingId,
    DateTime clockInTime,
    DateTime? clockOutTime,
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
    double? totalHours,
    int breakTimeMinutes,
    double overtimeHours,
    String status,
    bool isValid,
    String? validationNotes,
    bool adminAdjusted,
    String? adminNotes,
    String? adjustedBy,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ClockRecordModelImplCopyWithImpl<$Res>
    extends _$ClockRecordModelCopyWithImpl<$Res, _$ClockRecordModelImpl>
    implements _$$ClockRecordModelImplCopyWith<$Res> {
  __$$ClockRecordModelImplCopyWithImpl(
    _$ClockRecordModelImpl _value,
    $Res Function(_$ClockRecordModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClockRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? shiftBookingId = freezed,
    Object? clockInTime = null,
    Object? clockOutTime = freezed,
    Object? clockInWifiSsid = freezed,
    Object? clockInWifiBssid = freezed,
    Object? clockInLatitude = freezed,
    Object? clockInLongitude = freezed,
    Object? clockInDeviceInfo = freezed,
    Object? clockOutWifiSsid = freezed,
    Object? clockOutWifiBssid = freezed,
    Object? clockOutLatitude = freezed,
    Object? clockOutLongitude = freezed,
    Object? clockOutDeviceInfo = freezed,
    Object? totalHours = freezed,
    Object? breakTimeMinutes = null,
    Object? overtimeHours = null,
    Object? status = null,
    Object? isValid = null,
    Object? validationNotes = freezed,
    Object? adminAdjusted = null,
    Object? adminNotes = freezed,
    Object? adjustedBy = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ClockRecordModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        shiftBookingId: freezed == shiftBookingId
            ? _value.shiftBookingId
            : shiftBookingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockInTime: null == clockInTime
            ? _value.clockInTime
            : clockInTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        clockOutTime: freezed == clockOutTime
            ? _value.clockOutTime
            : clockOutTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        clockInWifiSsid: freezed == clockInWifiSsid
            ? _value.clockInWifiSsid
            : clockInWifiSsid // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockInWifiBssid: freezed == clockInWifiBssid
            ? _value.clockInWifiBssid
            : clockInWifiBssid // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockInLatitude: freezed == clockInLatitude
            ? _value.clockInLatitude
            : clockInLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        clockInLongitude: freezed == clockInLongitude
            ? _value.clockInLongitude
            : clockInLongitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        clockInDeviceInfo: freezed == clockInDeviceInfo
            ? _value._clockInDeviceInfo
            : clockInDeviceInfo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        clockOutWifiSsid: freezed == clockOutWifiSsid
            ? _value.clockOutWifiSsid
            : clockOutWifiSsid // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockOutWifiBssid: freezed == clockOutWifiBssid
            ? _value.clockOutWifiBssid
            : clockOutWifiBssid // ignore: cast_nullable_to_non_nullable
                  as String?,
        clockOutLatitude: freezed == clockOutLatitude
            ? _value.clockOutLatitude
            : clockOutLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        clockOutLongitude: freezed == clockOutLongitude
            ? _value.clockOutLongitude
            : clockOutLongitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        clockOutDeviceInfo: freezed == clockOutDeviceInfo
            ? _value._clockOutDeviceInfo
            : clockOutDeviceInfo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        totalHours: freezed == totalHours
            ? _value.totalHours
            : totalHours // ignore: cast_nullable_to_non_nullable
                  as double?,
        breakTimeMinutes: null == breakTimeMinutes
            ? _value.breakTimeMinutes
            : breakTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        overtimeHours: null == overtimeHours
            ? _value.overtimeHours
            : overtimeHours // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        isValid: null == isValid
            ? _value.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        validationNotes: freezed == validationNotes
            ? _value.validationNotes
            : validationNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        adminAdjusted: null == adminAdjusted
            ? _value.adminAdjusted
            : adminAdjusted // ignore: cast_nullable_to_non_nullable
                  as bool,
        adminNotes: freezed == adminNotes
            ? _value.adminNotes
            : adminNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        adjustedBy: freezed == adjustedBy
            ? _value.adjustedBy
            : adjustedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClockRecordModelImpl implements _ClockRecordModel {
  const _$ClockRecordModelImpl({
    required this.id,
    required this.userId,
    this.shiftBookingId,
    required this.clockInTime,
    this.clockOutTime,
    this.clockInWifiSsid,
    this.clockInWifiBssid,
    this.clockInLatitude,
    this.clockInLongitude,
    final Map<String, dynamic>? clockInDeviceInfo,
    this.clockOutWifiSsid,
    this.clockOutWifiBssid,
    this.clockOutLatitude,
    this.clockOutLongitude,
    final Map<String, dynamic>? clockOutDeviceInfo,
    this.totalHours,
    this.breakTimeMinutes = 0,
    this.overtimeHours = 0,
    this.status = 'clocked_in',
    this.isValid = true,
    this.validationNotes,
    this.adminAdjusted = false,
    this.adminNotes,
    this.adjustedBy,
    required this.createdAt,
    required this.updatedAt,
  }) : _clockInDeviceInfo = clockInDeviceInfo,
       _clockOutDeviceInfo = clockOutDeviceInfo;

  factory _$ClockRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClockRecordModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? shiftBookingId;
  @override
  final DateTime clockInTime;
  @override
  final DateTime? clockOutTime;
  // Security & Location Data
  @override
  final String? clockInWifiSsid;
  @override
  final String? clockInWifiBssid;
  @override
  final double? clockInLatitude;
  @override
  final double? clockInLongitude;
  final Map<String, dynamic>? _clockInDeviceInfo;
  @override
  Map<String, dynamic>? get clockInDeviceInfo {
    final value = _clockInDeviceInfo;
    if (value == null) return null;
    if (_clockInDeviceInfo is EqualUnmodifiableMapView)
      return _clockInDeviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? clockOutWifiSsid;
  @override
  final String? clockOutWifiBssid;
  @override
  final double? clockOutLatitude;
  @override
  final double? clockOutLongitude;
  final Map<String, dynamic>? _clockOutDeviceInfo;
  @override
  Map<String, dynamic>? get clockOutDeviceInfo {
    final value = _clockOutDeviceInfo;
    if (value == null) return null;
    if (_clockOutDeviceInfo is EqualUnmodifiableMapView)
      return _clockOutDeviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Calculated fields
  @override
  final double? totalHours;
  @override
  @JsonKey()
  final int breakTimeMinutes;
  @override
  @JsonKey()
  final double overtimeHours;
  // Status and validation
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool isValid;
  @override
  final String? validationNotes;
  // Admin override
  @override
  @JsonKey()
  final bool adminAdjusted;
  @override
  final String? adminNotes;
  @override
  final String? adjustedBy;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ClockRecordModel(id: $id, userId: $userId, shiftBookingId: $shiftBookingId, clockInTime: $clockInTime, clockOutTime: $clockOutTime, clockInWifiSsid: $clockInWifiSsid, clockInWifiBssid: $clockInWifiBssid, clockInLatitude: $clockInLatitude, clockInLongitude: $clockInLongitude, clockInDeviceInfo: $clockInDeviceInfo, clockOutWifiSsid: $clockOutWifiSsid, clockOutWifiBssid: $clockOutWifiBssid, clockOutLatitude: $clockOutLatitude, clockOutLongitude: $clockOutLongitude, clockOutDeviceInfo: $clockOutDeviceInfo, totalHours: $totalHours, breakTimeMinutes: $breakTimeMinutes, overtimeHours: $overtimeHours, status: $status, isValid: $isValid, validationNotes: $validationNotes, adminAdjusted: $adminAdjusted, adminNotes: $adminNotes, adjustedBy: $adjustedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClockRecordModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.shiftBookingId, shiftBookingId) ||
                other.shiftBookingId == shiftBookingId) &&
            (identical(other.clockInTime, clockInTime) ||
                other.clockInTime == clockInTime) &&
            (identical(other.clockOutTime, clockOutTime) ||
                other.clockOutTime == clockOutTime) &&
            (identical(other.clockInWifiSsid, clockInWifiSsid) ||
                other.clockInWifiSsid == clockInWifiSsid) &&
            (identical(other.clockInWifiBssid, clockInWifiBssid) ||
                other.clockInWifiBssid == clockInWifiBssid) &&
            (identical(other.clockInLatitude, clockInLatitude) ||
                other.clockInLatitude == clockInLatitude) &&
            (identical(other.clockInLongitude, clockInLongitude) ||
                other.clockInLongitude == clockInLongitude) &&
            const DeepCollectionEquality().equals(
              other._clockInDeviceInfo,
              _clockInDeviceInfo,
            ) &&
            (identical(other.clockOutWifiSsid, clockOutWifiSsid) ||
                other.clockOutWifiSsid == clockOutWifiSsid) &&
            (identical(other.clockOutWifiBssid, clockOutWifiBssid) ||
                other.clockOutWifiBssid == clockOutWifiBssid) &&
            (identical(other.clockOutLatitude, clockOutLatitude) ||
                other.clockOutLatitude == clockOutLatitude) &&
            (identical(other.clockOutLongitude, clockOutLongitude) ||
                other.clockOutLongitude == clockOutLongitude) &&
            const DeepCollectionEquality().equals(
              other._clockOutDeviceInfo,
              _clockOutDeviceInfo,
            ) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.breakTimeMinutes, breakTimeMinutes) ||
                other.breakTimeMinutes == breakTimeMinutes) &&
            (identical(other.overtimeHours, overtimeHours) ||
                other.overtimeHours == overtimeHours) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.validationNotes, validationNotes) ||
                other.validationNotes == validationNotes) &&
            (identical(other.adminAdjusted, adminAdjusted) ||
                other.adminAdjusted == adminAdjusted) &&
            (identical(other.adminNotes, adminNotes) ||
                other.adminNotes == adminNotes) &&
            (identical(other.adjustedBy, adjustedBy) ||
                other.adjustedBy == adjustedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    shiftBookingId,
    clockInTime,
    clockOutTime,
    clockInWifiSsid,
    clockInWifiBssid,
    clockInLatitude,
    clockInLongitude,
    const DeepCollectionEquality().hash(_clockInDeviceInfo),
    clockOutWifiSsid,
    clockOutWifiBssid,
    clockOutLatitude,
    clockOutLongitude,
    const DeepCollectionEquality().hash(_clockOutDeviceInfo),
    totalHours,
    breakTimeMinutes,
    overtimeHours,
    status,
    isValid,
    validationNotes,
    adminAdjusted,
    adminNotes,
    adjustedBy,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of ClockRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClockRecordModelImplCopyWith<_$ClockRecordModelImpl> get copyWith =>
      __$$ClockRecordModelImplCopyWithImpl<_$ClockRecordModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClockRecordModelImplToJson(this);
  }
}

abstract class _ClockRecordModel implements ClockRecordModel {
  const factory _ClockRecordModel({
    required final String id,
    required final String userId,
    final String? shiftBookingId,
    required final DateTime clockInTime,
    final DateTime? clockOutTime,
    final String? clockInWifiSsid,
    final String? clockInWifiBssid,
    final double? clockInLatitude,
    final double? clockInLongitude,
    final Map<String, dynamic>? clockInDeviceInfo,
    final String? clockOutWifiSsid,
    final String? clockOutWifiBssid,
    final double? clockOutLatitude,
    final double? clockOutLongitude,
    final Map<String, dynamic>? clockOutDeviceInfo,
    final double? totalHours,
    final int breakTimeMinutes,
    final double overtimeHours,
    final String status,
    final bool isValid,
    final String? validationNotes,
    final bool adminAdjusted,
    final String? adminNotes,
    final String? adjustedBy,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ClockRecordModelImpl;

  factory _ClockRecordModel.fromJson(Map<String, dynamic> json) =
      _$ClockRecordModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get shiftBookingId;
  @override
  DateTime get clockInTime;
  @override
  DateTime? get clockOutTime; // Security & Location Data
  @override
  String? get clockInWifiSsid;
  @override
  String? get clockInWifiBssid;
  @override
  double? get clockInLatitude;
  @override
  double? get clockInLongitude;
  @override
  Map<String, dynamic>? get clockInDeviceInfo;
  @override
  String? get clockOutWifiSsid;
  @override
  String? get clockOutWifiBssid;
  @override
  double? get clockOutLatitude;
  @override
  double? get clockOutLongitude;
  @override
  Map<String, dynamic>? get clockOutDeviceInfo; // Calculated fields
  @override
  double? get totalHours;
  @override
  int get breakTimeMinutes;
  @override
  double get overtimeHours; // Status and validation
  @override
  String get status;
  @override
  bool get isValid;
  @override
  String? get validationNotes; // Admin override
  @override
  bool get adminAdjusted;
  @override
  String? get adminNotes;
  @override
  String? get adjustedBy;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ClockRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClockRecordModelImplCopyWith<_$ClockRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClockInRequest _$ClockInRequestFromJson(Map<String, dynamic> json) {
  return _ClockInRequest.fromJson(json);
}

/// @nodoc
mixin _$ClockInRequest {
  String? get shiftBookingId => throw _privateConstructorUsedError;
  String? get wifiSsid => throw _privateConstructorUsedError;
  String? get wifiBssid => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  Map<String, dynamic>? get deviceInfo => throw _privateConstructorUsedError;

  /// Serializes this ClockInRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClockInRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClockInRequestCopyWith<ClockInRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClockInRequestCopyWith<$Res> {
  factory $ClockInRequestCopyWith(
    ClockInRequest value,
    $Res Function(ClockInRequest) then,
  ) = _$ClockInRequestCopyWithImpl<$Res, ClockInRequest>;
  @useResult
  $Res call({
    String? shiftBookingId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
  });
}

/// @nodoc
class _$ClockInRequestCopyWithImpl<$Res, $Val extends ClockInRequest>
    implements $ClockInRequestCopyWith<$Res> {
  _$ClockInRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClockInRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftBookingId = freezed,
    Object? wifiSsid = freezed,
    Object? wifiBssid = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deviceInfo = freezed,
  }) {
    return _then(
      _value.copyWith(
            shiftBookingId: freezed == shiftBookingId
                ? _value.shiftBookingId
                : shiftBookingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            wifiSsid: freezed == wifiSsid
                ? _value.wifiSsid
                : wifiSsid // ignore: cast_nullable_to_non_nullable
                      as String?,
            wifiBssid: freezed == wifiBssid
                ? _value.wifiBssid
                : wifiBssid // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            deviceInfo: freezed == deviceInfo
                ? _value.deviceInfo
                : deviceInfo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClockInRequestImplCopyWith<$Res>
    implements $ClockInRequestCopyWith<$Res> {
  factory _$$ClockInRequestImplCopyWith(
    _$ClockInRequestImpl value,
    $Res Function(_$ClockInRequestImpl) then,
  ) = __$$ClockInRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? shiftBookingId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
  });
}

/// @nodoc
class __$$ClockInRequestImplCopyWithImpl<$Res>
    extends _$ClockInRequestCopyWithImpl<$Res, _$ClockInRequestImpl>
    implements _$$ClockInRequestImplCopyWith<$Res> {
  __$$ClockInRequestImplCopyWithImpl(
    _$ClockInRequestImpl _value,
    $Res Function(_$ClockInRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClockInRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftBookingId = freezed,
    Object? wifiSsid = freezed,
    Object? wifiBssid = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deviceInfo = freezed,
  }) {
    return _then(
      _$ClockInRequestImpl(
        shiftBookingId: freezed == shiftBookingId
            ? _value.shiftBookingId
            : shiftBookingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        wifiSsid: freezed == wifiSsid
            ? _value.wifiSsid
            : wifiSsid // ignore: cast_nullable_to_non_nullable
                  as String?,
        wifiBssid: freezed == wifiBssid
            ? _value.wifiBssid
            : wifiBssid // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        deviceInfo: freezed == deviceInfo
            ? _value._deviceInfo
            : deviceInfo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClockInRequestImpl implements _ClockInRequest {
  const _$ClockInRequestImpl({
    this.shiftBookingId,
    this.wifiSsid,
    this.wifiBssid,
    this.latitude,
    this.longitude,
    final Map<String, dynamic>? deviceInfo,
  }) : _deviceInfo = deviceInfo;

  factory _$ClockInRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClockInRequestImplFromJson(json);

  @override
  final String? shiftBookingId;
  @override
  final String? wifiSsid;
  @override
  final String? wifiBssid;
  @override
  final double? latitude;
  @override
  final double? longitude;
  final Map<String, dynamic>? _deviceInfo;
  @override
  Map<String, dynamic>? get deviceInfo {
    final value = _deviceInfo;
    if (value == null) return null;
    if (_deviceInfo is EqualUnmodifiableMapView) return _deviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ClockInRequest(shiftBookingId: $shiftBookingId, wifiSsid: $wifiSsid, wifiBssid: $wifiBssid, latitude: $latitude, longitude: $longitude, deviceInfo: $deviceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClockInRequestImpl &&
            (identical(other.shiftBookingId, shiftBookingId) ||
                other.shiftBookingId == shiftBookingId) &&
            (identical(other.wifiSsid, wifiSsid) ||
                other.wifiSsid == wifiSsid) &&
            (identical(other.wifiBssid, wifiBssid) ||
                other.wifiBssid == wifiBssid) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
              other._deviceInfo,
              _deviceInfo,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    shiftBookingId,
    wifiSsid,
    wifiBssid,
    latitude,
    longitude,
    const DeepCollectionEquality().hash(_deviceInfo),
  );

  /// Create a copy of ClockInRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClockInRequestImplCopyWith<_$ClockInRequestImpl> get copyWith =>
      __$$ClockInRequestImplCopyWithImpl<_$ClockInRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClockInRequestImplToJson(this);
  }
}

abstract class _ClockInRequest implements ClockInRequest {
  const factory _ClockInRequest({
    final String? shiftBookingId,
    final String? wifiSsid,
    final String? wifiBssid,
    final double? latitude,
    final double? longitude,
    final Map<String, dynamic>? deviceInfo,
  }) = _$ClockInRequestImpl;

  factory _ClockInRequest.fromJson(Map<String, dynamic> json) =
      _$ClockInRequestImpl.fromJson;

  @override
  String? get shiftBookingId;
  @override
  String? get wifiSsid;
  @override
  String? get wifiBssid;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  Map<String, dynamic>? get deviceInfo;

  /// Create a copy of ClockInRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClockInRequestImplCopyWith<_$ClockInRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClockOutRequest _$ClockOutRequestFromJson(Map<String, dynamic> json) {
  return _ClockOutRequest.fromJson(json);
}

/// @nodoc
mixin _$ClockOutRequest {
  String get clockRecordId => throw _privateConstructorUsedError;
  String? get wifiSsid => throw _privateConstructorUsedError;
  String? get wifiBssid => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  Map<String, dynamic>? get deviceInfo => throw _privateConstructorUsedError;
  int? get breakTimeMinutes => throw _privateConstructorUsedError;

  /// Serializes this ClockOutRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClockOutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClockOutRequestCopyWith<ClockOutRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClockOutRequestCopyWith<$Res> {
  factory $ClockOutRequestCopyWith(
    ClockOutRequest value,
    $Res Function(ClockOutRequest) then,
  ) = _$ClockOutRequestCopyWithImpl<$Res, ClockOutRequest>;
  @useResult
  $Res call({
    String clockRecordId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
    int? breakTimeMinutes,
  });
}

/// @nodoc
class _$ClockOutRequestCopyWithImpl<$Res, $Val extends ClockOutRequest>
    implements $ClockOutRequestCopyWith<$Res> {
  _$ClockOutRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClockOutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clockRecordId = null,
    Object? wifiSsid = freezed,
    Object? wifiBssid = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deviceInfo = freezed,
    Object? breakTimeMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            clockRecordId: null == clockRecordId
                ? _value.clockRecordId
                : clockRecordId // ignore: cast_nullable_to_non_nullable
                      as String,
            wifiSsid: freezed == wifiSsid
                ? _value.wifiSsid
                : wifiSsid // ignore: cast_nullable_to_non_nullable
                      as String?,
            wifiBssid: freezed == wifiBssid
                ? _value.wifiBssid
                : wifiBssid // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            deviceInfo: freezed == deviceInfo
                ? _value.deviceInfo
                : deviceInfo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            breakTimeMinutes: freezed == breakTimeMinutes
                ? _value.breakTimeMinutes
                : breakTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClockOutRequestImplCopyWith<$Res>
    implements $ClockOutRequestCopyWith<$Res> {
  factory _$$ClockOutRequestImplCopyWith(
    _$ClockOutRequestImpl value,
    $Res Function(_$ClockOutRequestImpl) then,
  ) = __$$ClockOutRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String clockRecordId,
    String? wifiSsid,
    String? wifiBssid,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? deviceInfo,
    int? breakTimeMinutes,
  });
}

/// @nodoc
class __$$ClockOutRequestImplCopyWithImpl<$Res>
    extends _$ClockOutRequestCopyWithImpl<$Res, _$ClockOutRequestImpl>
    implements _$$ClockOutRequestImplCopyWith<$Res> {
  __$$ClockOutRequestImplCopyWithImpl(
    _$ClockOutRequestImpl _value,
    $Res Function(_$ClockOutRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClockOutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clockRecordId = null,
    Object? wifiSsid = freezed,
    Object? wifiBssid = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deviceInfo = freezed,
    Object? breakTimeMinutes = freezed,
  }) {
    return _then(
      _$ClockOutRequestImpl(
        clockRecordId: null == clockRecordId
            ? _value.clockRecordId
            : clockRecordId // ignore: cast_nullable_to_non_nullable
                  as String,
        wifiSsid: freezed == wifiSsid
            ? _value.wifiSsid
            : wifiSsid // ignore: cast_nullable_to_non_nullable
                  as String?,
        wifiBssid: freezed == wifiBssid
            ? _value.wifiBssid
            : wifiBssid // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        deviceInfo: freezed == deviceInfo
            ? _value._deviceInfo
            : deviceInfo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        breakTimeMinutes: freezed == breakTimeMinutes
            ? _value.breakTimeMinutes
            : breakTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClockOutRequestImpl implements _ClockOutRequest {
  const _$ClockOutRequestImpl({
    required this.clockRecordId,
    this.wifiSsid,
    this.wifiBssid,
    this.latitude,
    this.longitude,
    final Map<String, dynamic>? deviceInfo,
    this.breakTimeMinutes,
  }) : _deviceInfo = deviceInfo;

  factory _$ClockOutRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClockOutRequestImplFromJson(json);

  @override
  final String clockRecordId;
  @override
  final String? wifiSsid;
  @override
  final String? wifiBssid;
  @override
  final double? latitude;
  @override
  final double? longitude;
  final Map<String, dynamic>? _deviceInfo;
  @override
  Map<String, dynamic>? get deviceInfo {
    final value = _deviceInfo;
    if (value == null) return null;
    if (_deviceInfo is EqualUnmodifiableMapView) return _deviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? breakTimeMinutes;

  @override
  String toString() {
    return 'ClockOutRequest(clockRecordId: $clockRecordId, wifiSsid: $wifiSsid, wifiBssid: $wifiBssid, latitude: $latitude, longitude: $longitude, deviceInfo: $deviceInfo, breakTimeMinutes: $breakTimeMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClockOutRequestImpl &&
            (identical(other.clockRecordId, clockRecordId) ||
                other.clockRecordId == clockRecordId) &&
            (identical(other.wifiSsid, wifiSsid) ||
                other.wifiSsid == wifiSsid) &&
            (identical(other.wifiBssid, wifiBssid) ||
                other.wifiBssid == wifiBssid) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
              other._deviceInfo,
              _deviceInfo,
            ) &&
            (identical(other.breakTimeMinutes, breakTimeMinutes) ||
                other.breakTimeMinutes == breakTimeMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    clockRecordId,
    wifiSsid,
    wifiBssid,
    latitude,
    longitude,
    const DeepCollectionEquality().hash(_deviceInfo),
    breakTimeMinutes,
  );

  /// Create a copy of ClockOutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClockOutRequestImplCopyWith<_$ClockOutRequestImpl> get copyWith =>
      __$$ClockOutRequestImplCopyWithImpl<_$ClockOutRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClockOutRequestImplToJson(this);
  }
}

abstract class _ClockOutRequest implements ClockOutRequest {
  const factory _ClockOutRequest({
    required final String clockRecordId,
    final String? wifiSsid,
    final String? wifiBssid,
    final double? latitude,
    final double? longitude,
    final Map<String, dynamic>? deviceInfo,
    final int? breakTimeMinutes,
  }) = _$ClockOutRequestImpl;

  factory _ClockOutRequest.fromJson(Map<String, dynamic> json) =
      _$ClockOutRequestImpl.fromJson;

  @override
  String get clockRecordId;
  @override
  String? get wifiSsid;
  @override
  String? get wifiBssid;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  Map<String, dynamic>? get deviceInfo;
  @override
  int? get breakTimeMinutes;

  /// Create a copy of ClockOutRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClockOutRequestImplCopyWith<_$ClockOutRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) {
  return _LocationInfo.fromJson(json);
}

/// @nodoc
mixin _$LocationInfo {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get accuracy => throw _privateConstructorUsedError;
  double? get altitude => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this LocationInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationInfoCopyWith<LocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationInfoCopyWith<$Res> {
  factory $LocationInfoCopyWith(
    LocationInfo value,
    $Res Function(LocationInfo) then,
  ) = _$LocationInfoCopyWithImpl<$Res, LocationInfo>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
  });
}

/// @nodoc
class _$LocationInfoCopyWithImpl<$Res, $Val extends LocationInfo>
    implements $LocationInfoCopyWith<$Res> {
  _$LocationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = freezed,
    Object? altitude = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            accuracy: freezed == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double?,
            altitude: freezed == altitude
                ? _value.altitude
                : altitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationInfoImplCopyWith<$Res>
    implements $LocationInfoCopyWith<$Res> {
  factory _$$LocationInfoImplCopyWith(
    _$LocationInfoImpl value,
    $Res Function(_$LocationInfoImpl) then,
  ) = __$$LocationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
  });
}

/// @nodoc
class __$$LocationInfoImplCopyWithImpl<$Res>
    extends _$LocationInfoCopyWithImpl<$Res, _$LocationInfoImpl>
    implements _$$LocationInfoImplCopyWith<$Res> {
  __$$LocationInfoImplCopyWithImpl(
    _$LocationInfoImpl _value,
    $Res Function(_$LocationInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = freezed,
    Object? altitude = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$LocationInfoImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracy: freezed == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double?,
        altitude: freezed == altitude
            ? _value.altitude
            : altitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationInfoImpl implements _LocationInfo {
  const _$LocationInfoImpl({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.timestamp,
  });

  factory _$LocationInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationInfoImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? accuracy;
  @override
  final double? altitude;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'LocationInfo(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationInfoImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    accuracy,
    altitude,
    timestamp,
  );

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationInfoImplCopyWith<_$LocationInfoImpl> get copyWith =>
      __$$LocationInfoImplCopyWithImpl<_$LocationInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationInfoImplToJson(this);
  }
}

abstract class _LocationInfo implements LocationInfo {
  const factory _LocationInfo({
    required final double latitude,
    required final double longitude,
    final double? accuracy,
    final double? altitude,
    final DateTime? timestamp,
  }) = _$LocationInfoImpl;

  factory _LocationInfo.fromJson(Map<String, dynamic> json) =
      _$LocationInfoImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get accuracy;
  @override
  double? get altitude;
  @override
  DateTime? get timestamp;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationInfoImplCopyWith<_$LocationInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String? get deviceId => throw _privateConstructorUsedError;
  String? get deviceModel => throw _privateConstructorUsedError;
  String? get osVersion => throw _privateConstructorUsedError;
  String? get appVersion => throw _privateConstructorUsedError;
  bool? get isRooted => throw _privateConstructorUsedError;
  bool? get isEmulator => throw _privateConstructorUsedError;
  String? get fingerprint => throw _privateConstructorUsedError;

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
    DeviceInfo value,
    $Res Function(DeviceInfo) then,
  ) = _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call({
    String? deviceId,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    bool? isRooted,
    bool? isEmulator,
    String? fingerprint,
  });
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? isRooted = freezed,
    Object? isEmulator = freezed,
    Object? fingerprint = freezed,
  }) {
    return _then(
      _value.copyWith(
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceModel: freezed == deviceModel
                ? _value.deviceModel
                : deviceModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            osVersion: freezed == osVersion
                ? _value.osVersion
                : osVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            appVersion: freezed == appVersion
                ? _value.appVersion
                : appVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRooted: freezed == isRooted
                ? _value.isRooted
                : isRooted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isEmulator: freezed == isEmulator
                ? _value.isEmulator
                : isEmulator // ignore: cast_nullable_to_non_nullable
                      as bool?,
            fingerprint: freezed == fingerprint
                ? _value.fingerprint
                : fingerprint // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
    _$DeviceInfoImpl value,
    $Res Function(_$DeviceInfoImpl) then,
  ) = __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? deviceId,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    bool? isRooted,
    bool? isEmulator,
    String? fingerprint,
  });
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
    _$DeviceInfoImpl _value,
    $Res Function(_$DeviceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? isRooted = freezed,
    Object? isEmulator = freezed,
    Object? fingerprint = freezed,
  }) {
    return _then(
      _$DeviceInfoImpl(
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceModel: freezed == deviceModel
            ? _value.deviceModel
            : deviceModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        osVersion: freezed == osVersion
            ? _value.osVersion
            : osVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        appVersion: freezed == appVersion
            ? _value.appVersion
            : appVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRooted: freezed == isRooted
            ? _value.isRooted
            : isRooted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isEmulator: freezed == isEmulator
            ? _value.isEmulator
            : isEmulator // ignore: cast_nullable_to_non_nullable
                  as bool?,
        fingerprint: freezed == fingerprint
            ? _value.fingerprint
            : fingerprint // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl({
    this.deviceId,
    this.deviceModel,
    this.osVersion,
    this.appVersion,
    this.isRooted,
    this.isEmulator,
    this.fingerprint,
  });

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String? deviceId;
  @override
  final String? deviceModel;
  @override
  final String? osVersion;
  @override
  final String? appVersion;
  @override
  final bool? isRooted;
  @override
  final bool? isEmulator;
  @override
  final String? fingerprint;

  @override
  String toString() {
    return 'DeviceInfo(deviceId: $deviceId, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, isRooted: $isRooted, isEmulator: $isEmulator, fingerprint: $fingerprint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.isRooted, isRooted) ||
                other.isRooted == isRooted) &&
            (identical(other.isEmulator, isEmulator) ||
                other.isEmulator == isEmulator) &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    deviceId,
    deviceModel,
    osVersion,
    appVersion,
    isRooted,
    isEmulator,
    fingerprint,
  );

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(this);
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo({
    final String? deviceId,
    final String? deviceModel,
    final String? osVersion,
    final String? appVersion,
    final bool? isRooted,
    final bool? isEmulator,
    final String? fingerprint,
  }) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String? get deviceId;
  @override
  String? get deviceModel;
  @override
  String? get osVersion;
  @override
  String? get appVersion;
  @override
  bool? get isRooted;
  @override
  bool? get isEmulator;
  @override
  String? get fingerprint;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkSummary _$WorkSummaryFromJson(Map<String, dynamic> json) {
  return _WorkSummary.fromJson(json);
}

/// @nodoc
mixin _$WorkSummary {
  String get userId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  double get totalHours => throw _privateConstructorUsedError;
  double get overtimeHours => throw _privateConstructorUsedError;
  int get totalSessions => throw _privateConstructorUsedError;
  List<ClockRecordModel> get records => throw _privateConstructorUsedError;

  /// Serializes this WorkSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkSummaryCopyWith<WorkSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkSummaryCopyWith<$Res> {
  factory $WorkSummaryCopyWith(
    WorkSummary value,
    $Res Function(WorkSummary) then,
  ) = _$WorkSummaryCopyWithImpl<$Res, WorkSummary>;
  @useResult
  $Res call({
    String userId,
    DateTime startDate,
    DateTime endDate,
    double totalHours,
    double overtimeHours,
    int totalSessions,
    List<ClockRecordModel> records,
  });
}

/// @nodoc
class _$WorkSummaryCopyWithImpl<$Res, $Val extends WorkSummary>
    implements $WorkSummaryCopyWith<$Res> {
  _$WorkSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalHours = null,
    Object? overtimeHours = null,
    Object? totalSessions = null,
    Object? records = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalHours: null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                      as double,
            overtimeHours: null == overtimeHours
                ? _value.overtimeHours
                : overtimeHours // ignore: cast_nullable_to_non_nullable
                      as double,
            totalSessions: null == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                      as int,
            records: null == records
                ? _value.records
                : records // ignore: cast_nullable_to_non_nullable
                      as List<ClockRecordModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkSummaryImplCopyWith<$Res>
    implements $WorkSummaryCopyWith<$Res> {
  factory _$$WorkSummaryImplCopyWith(
    _$WorkSummaryImpl value,
    $Res Function(_$WorkSummaryImpl) then,
  ) = __$$WorkSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    DateTime startDate,
    DateTime endDate,
    double totalHours,
    double overtimeHours,
    int totalSessions,
    List<ClockRecordModel> records,
  });
}

/// @nodoc
class __$$WorkSummaryImplCopyWithImpl<$Res>
    extends _$WorkSummaryCopyWithImpl<$Res, _$WorkSummaryImpl>
    implements _$$WorkSummaryImplCopyWith<$Res> {
  __$$WorkSummaryImplCopyWithImpl(
    _$WorkSummaryImpl _value,
    $Res Function(_$WorkSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalHours = null,
    Object? overtimeHours = null,
    Object? totalSessions = null,
    Object? records = null,
  }) {
    return _then(
      _$WorkSummaryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalHours: null == totalHours
            ? _value.totalHours
            : totalHours // ignore: cast_nullable_to_non_nullable
                  as double,
        overtimeHours: null == overtimeHours
            ? _value.overtimeHours
            : overtimeHours // ignore: cast_nullable_to_non_nullable
                  as double,
        totalSessions: null == totalSessions
            ? _value.totalSessions
            : totalSessions // ignore: cast_nullable_to_non_nullable
                  as int,
        records: null == records
            ? _value._records
            : records // ignore: cast_nullable_to_non_nullable
                  as List<ClockRecordModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkSummaryImpl implements _WorkSummary {
  const _$WorkSummaryImpl({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalHours,
    required this.overtimeHours,
    required this.totalSessions,
    required final List<ClockRecordModel> records,
  }) : _records = records;

  factory _$WorkSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkSummaryImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final double totalHours;
  @override
  final double overtimeHours;
  @override
  final int totalSessions;
  final List<ClockRecordModel> _records;
  @override
  List<ClockRecordModel> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  String toString() {
    return 'WorkSummary(userId: $userId, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, overtimeHours: $overtimeHours, totalSessions: $totalSessions, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.overtimeHours, overtimeHours) ||
                other.overtimeHours == overtimeHours) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    startDate,
    endDate,
    totalHours,
    overtimeHours,
    totalSessions,
    const DeepCollectionEquality().hash(_records),
  );

  /// Create a copy of WorkSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkSummaryImplCopyWith<_$WorkSummaryImpl> get copyWith =>
      __$$WorkSummaryImplCopyWithImpl<_$WorkSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkSummaryImplToJson(this);
  }
}

abstract class _WorkSummary implements WorkSummary {
  const factory _WorkSummary({
    required final String userId,
    required final DateTime startDate,
    required final DateTime endDate,
    required final double totalHours,
    required final double overtimeHours,
    required final int totalSessions,
    required final List<ClockRecordModel> records,
  }) = _$WorkSummaryImpl;

  factory _WorkSummary.fromJson(Map<String, dynamic> json) =
      _$WorkSummaryImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  double get totalHours;
  @override
  double get overtimeHours;
  @override
  int get totalSessions;
  @override
  List<ClockRecordModel> get records;

  /// Create a copy of WorkSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkSummaryImplCopyWith<_$WorkSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
