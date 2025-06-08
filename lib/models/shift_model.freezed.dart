// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) {
  return _ShiftModel.fromJson(json);
}

/// @nodoc
mixin _$ShiftModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int get maxStaff => throw _privateConstructorUsedError;
  double? get hourlyRate => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ShiftModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftModelCopyWith<ShiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftModelCopyWith<$Res> {
  factory $ShiftModelCopyWith(
    ShiftModel value,
    $Res Function(ShiftModel) then,
  ) = _$ShiftModelCopyWithImpl<$Res, ShiftModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    DateTime startTime,
    DateTime endTime,
    String? location,
    int maxStaff,
    double? hourlyRate,
    String createdBy,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ShiftModelCopyWithImpl<$Res, $Val extends ShiftModel>
    implements $ShiftModelCopyWith<$Res> {
  _$ShiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? maxStaff = null,
    Object? hourlyRate = freezed,
    Object? createdBy = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxStaff: null == maxStaff
                ? _value.maxStaff
                : maxStaff // ignore: cast_nullable_to_non_nullable
                      as int,
            hourlyRate: freezed == hourlyRate
                ? _value.hourlyRate
                : hourlyRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ShiftModelImplCopyWith<$Res>
    implements $ShiftModelCopyWith<$Res> {
  factory _$$ShiftModelImplCopyWith(
    _$ShiftModelImpl value,
    $Res Function(_$ShiftModelImpl) then,
  ) = __$$ShiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    DateTime startTime,
    DateTime endTime,
    String? location,
    int maxStaff,
    double? hourlyRate,
    String createdBy,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ShiftModelImplCopyWithImpl<$Res>
    extends _$ShiftModelCopyWithImpl<$Res, _$ShiftModelImpl>
    implements _$$ShiftModelImplCopyWith<$Res> {
  __$$ShiftModelImplCopyWithImpl(
    _$ShiftModelImpl _value,
    $Res Function(_$ShiftModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? maxStaff = null,
    Object? hourlyRate = freezed,
    Object? createdBy = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ShiftModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxStaff: null == maxStaff
            ? _value.maxStaff
            : maxStaff // ignore: cast_nullable_to_non_nullable
                  as int,
        hourlyRate: freezed == hourlyRate
            ? _value.hourlyRate
            : hourlyRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ShiftModelImpl implements _ShiftModel {
  const _$ShiftModelImpl({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.location,
    this.maxStaff = 1,
    this.hourlyRate,
    required this.createdBy,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$ShiftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String? location;
  @override
  @JsonKey()
  final int maxStaff;
  @override
  final double? hourlyRate;
  @override
  final String createdBy;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ShiftModel(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, maxStaff: $maxStaff, hourlyRate: $hourlyRate, createdBy: $createdBy, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.maxStaff, maxStaff) ||
                other.maxStaff == maxStaff) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    startTime,
    endTime,
    location,
    maxStaff,
    hourlyRate,
    createdBy,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftModelImplCopyWith<_$ShiftModelImpl> get copyWith =>
      __$$ShiftModelImplCopyWithImpl<_$ShiftModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftModelImplToJson(this);
  }
}

abstract class _ShiftModel implements ShiftModel {
  const factory _ShiftModel({
    required final String id,
    required final String title,
    final String? description,
    required final DateTime startTime,
    required final DateTime endTime,
    final String? location,
    final int maxStaff,
    final double? hourlyRate,
    required final String createdBy,
    final bool isActive,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ShiftModelImpl;

  factory _ShiftModel.fromJson(Map<String, dynamic> json) =
      _$ShiftModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String? get location;
  @override
  int get maxStaff;
  @override
  double? get hourlyRate;
  @override
  String get createdBy;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftModelImplCopyWith<_$ShiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftWithBookings _$ShiftWithBookingsFromJson(Map<String, dynamic> json) {
  return _ShiftWithBookings.fromJson(json);
}

/// @nodoc
mixin _$ShiftWithBookings {
  ShiftModel get shift => throw _privateConstructorUsedError;
  List<ShiftBookingModel> get bookings => throw _privateConstructorUsedError;
  int get availableSpots => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this ShiftWithBookings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftWithBookingsCopyWith<ShiftWithBookings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftWithBookingsCopyWith<$Res> {
  factory $ShiftWithBookingsCopyWith(
    ShiftWithBookings value,
    $Res Function(ShiftWithBookings) then,
  ) = _$ShiftWithBookingsCopyWithImpl<$Res, ShiftWithBookings>;
  @useResult
  $Res call({
    ShiftModel shift,
    List<ShiftBookingModel> bookings,
    int availableSpots,
    bool isAvailable,
  });

  $ShiftModelCopyWith<$Res> get shift;
}

/// @nodoc
class _$ShiftWithBookingsCopyWithImpl<$Res, $Val extends ShiftWithBookings>
    implements $ShiftWithBookingsCopyWith<$Res> {
  _$ShiftWithBookingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? bookings = null,
    Object? availableSpots = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            shift: null == shift
                ? _value.shift
                : shift // ignore: cast_nullable_to_non_nullable
                      as ShiftModel,
            bookings: null == bookings
                ? _value.bookings
                : bookings // ignore: cast_nullable_to_non_nullable
                      as List<ShiftBookingModel>,
            availableSpots: null == availableSpots
                ? _value.availableSpots
                : availableSpots // ignore: cast_nullable_to_non_nullable
                      as int,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShiftModelCopyWith<$Res> get shift {
    return $ShiftModelCopyWith<$Res>(_value.shift, (value) {
      return _then(_value.copyWith(shift: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShiftWithBookingsImplCopyWith<$Res>
    implements $ShiftWithBookingsCopyWith<$Res> {
  factory _$$ShiftWithBookingsImplCopyWith(
    _$ShiftWithBookingsImpl value,
    $Res Function(_$ShiftWithBookingsImpl) then,
  ) = __$$ShiftWithBookingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ShiftModel shift,
    List<ShiftBookingModel> bookings,
    int availableSpots,
    bool isAvailable,
  });

  @override
  $ShiftModelCopyWith<$Res> get shift;
}

/// @nodoc
class __$$ShiftWithBookingsImplCopyWithImpl<$Res>
    extends _$ShiftWithBookingsCopyWithImpl<$Res, _$ShiftWithBookingsImpl>
    implements _$$ShiftWithBookingsImplCopyWith<$Res> {
  __$$ShiftWithBookingsImplCopyWithImpl(
    _$ShiftWithBookingsImpl _value,
    $Res Function(_$ShiftWithBookingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? bookings = null,
    Object? availableSpots = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _$ShiftWithBookingsImpl(
        shift: null == shift
            ? _value.shift
            : shift // ignore: cast_nullable_to_non_nullable
                  as ShiftModel,
        bookings: null == bookings
            ? _value._bookings
            : bookings // ignore: cast_nullable_to_non_nullable
                  as List<ShiftBookingModel>,
        availableSpots: null == availableSpots
            ? _value.availableSpots
            : availableSpots // ignore: cast_nullable_to_non_nullable
                  as int,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftWithBookingsImpl implements _ShiftWithBookings {
  const _$ShiftWithBookingsImpl({
    required this.shift,
    required final List<ShiftBookingModel> bookings,
    required this.availableSpots,
    required this.isAvailable,
  }) : _bookings = bookings;

  factory _$ShiftWithBookingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftWithBookingsImplFromJson(json);

  @override
  final ShiftModel shift;
  final List<ShiftBookingModel> _bookings;
  @override
  List<ShiftBookingModel> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  final int availableSpots;
  @override
  final bool isAvailable;

  @override
  String toString() {
    return 'ShiftWithBookings(shift: $shift, bookings: $bookings, availableSpots: $availableSpots, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftWithBookingsImpl &&
            (identical(other.shift, shift) || other.shift == shift) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            (identical(other.availableSpots, availableSpots) ||
                other.availableSpots == availableSpots) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    shift,
    const DeepCollectionEquality().hash(_bookings),
    availableSpots,
    isAvailable,
  );

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftWithBookingsImplCopyWith<_$ShiftWithBookingsImpl> get copyWith =>
      __$$ShiftWithBookingsImplCopyWithImpl<_$ShiftWithBookingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftWithBookingsImplToJson(this);
  }
}

abstract class _ShiftWithBookings implements ShiftWithBookings {
  const factory _ShiftWithBookings({
    required final ShiftModel shift,
    required final List<ShiftBookingModel> bookings,
    required final int availableSpots,
    required final bool isAvailable,
  }) = _$ShiftWithBookingsImpl;

  factory _ShiftWithBookings.fromJson(Map<String, dynamic> json) =
      _$ShiftWithBookingsImpl.fromJson;

  @override
  ShiftModel get shift;
  @override
  List<ShiftBookingModel> get bookings;
  @override
  int get availableSpots;
  @override
  bool get isAvailable;

  /// Create a copy of ShiftWithBookings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftWithBookingsImplCopyWith<_$ShiftWithBookingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftBookingModel _$ShiftBookingModelFromJson(Map<String, dynamic> json) {
  return _ShiftBookingModel.fromJson(json);
}

/// @nodoc
mixin _$ShiftBookingModel {
  String get id => throw _privateConstructorUsedError;
  String get shiftId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get bookedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ShiftBookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftBookingModelCopyWith<ShiftBookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftBookingModelCopyWith<$Res> {
  factory $ShiftBookingModelCopyWith(
    ShiftBookingModel value,
    $Res Function(ShiftBookingModel) then,
  ) = _$ShiftBookingModelCopyWithImpl<$Res, ShiftBookingModel>;
  @useResult
  $Res call({
    String id,
    String shiftId,
    String userId,
    String status,
    DateTime bookedAt,
    DateTime? cancelledAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ShiftBookingModelCopyWithImpl<$Res, $Val extends ShiftBookingModel>
    implements $ShiftBookingModelCopyWith<$Res> {
  _$ShiftBookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shiftId = null,
    Object? userId = null,
    Object? status = null,
    Object? bookedAt = null,
    Object? cancelledAt = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            shiftId: null == shiftId
                ? _value.shiftId
                : shiftId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            bookedAt: null == bookedAt
                ? _value.bookedAt
                : bookedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ShiftBookingModelImplCopyWith<$Res>
    implements $ShiftBookingModelCopyWith<$Res> {
  factory _$$ShiftBookingModelImplCopyWith(
    _$ShiftBookingModelImpl value,
    $Res Function(_$ShiftBookingModelImpl) then,
  ) = __$$ShiftBookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String shiftId,
    String userId,
    String status,
    DateTime bookedAt,
    DateTime? cancelledAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ShiftBookingModelImplCopyWithImpl<$Res>
    extends _$ShiftBookingModelCopyWithImpl<$Res, _$ShiftBookingModelImpl>
    implements _$$ShiftBookingModelImplCopyWith<$Res> {
  __$$ShiftBookingModelImplCopyWithImpl(
    _$ShiftBookingModelImpl _value,
    $Res Function(_$ShiftBookingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shiftId = null,
    Object? userId = null,
    Object? status = null,
    Object? bookedAt = null,
    Object? cancelledAt = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ShiftBookingModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        shiftId: null == shiftId
            ? _value.shiftId
            : shiftId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        bookedAt: null == bookedAt
            ? _value.bookedAt
            : bookedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
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
class _$ShiftBookingModelImpl implements _ShiftBookingModel {
  const _$ShiftBookingModelImpl({
    required this.id,
    required this.shiftId,
    required this.userId,
    this.status = 'booked',
    required this.bookedAt,
    this.cancelledAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$ShiftBookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftBookingModelImplFromJson(json);

  @override
  final String id;
  @override
  final String shiftId;
  @override
  final String userId;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime bookedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ShiftBookingModel(id: $id, shiftId: $shiftId, userId: $userId, status: $status, bookedAt: $bookedAt, cancelledAt: $cancelledAt, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftBookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bookedAt, bookedAt) ||
                other.bookedAt == bookedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shiftId,
    userId,
    status,
    bookedAt,
    cancelledAt,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ShiftBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftBookingModelImplCopyWith<_$ShiftBookingModelImpl> get copyWith =>
      __$$ShiftBookingModelImplCopyWithImpl<_$ShiftBookingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftBookingModelImplToJson(this);
  }
}

abstract class _ShiftBookingModel implements ShiftBookingModel {
  const factory _ShiftBookingModel({
    required final String id,
    required final String shiftId,
    required final String userId,
    final String status,
    required final DateTime bookedAt,
    final DateTime? cancelledAt,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ShiftBookingModelImpl;

  factory _ShiftBookingModel.fromJson(Map<String, dynamic> json) =
      _$ShiftBookingModelImpl.fromJson;

  @override
  String get id;
  @override
  String get shiftId;
  @override
  String get userId;
  @override
  String get status;
  @override
  DateTime get bookedAt;
  @override
  DateTime? get cancelledAt;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ShiftBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftBookingModelImplCopyWith<_$ShiftBookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateShiftRequest _$CreateShiftRequestFromJson(Map<String, dynamic> json) {
  return _CreateShiftRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateShiftRequest {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int get maxStaff => throw _privateConstructorUsedError;
  double? get hourlyRate => throw _privateConstructorUsedError;

  /// Serializes this CreateShiftRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateShiftRequestCopyWith<CreateShiftRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateShiftRequestCopyWith<$Res> {
  factory $CreateShiftRequestCopyWith(
    CreateShiftRequest value,
    $Res Function(CreateShiftRequest) then,
  ) = _$CreateShiftRequestCopyWithImpl<$Res, CreateShiftRequest>;
  @useResult
  $Res call({
    String title,
    String? description,
    DateTime startTime,
    DateTime endTime,
    String? location,
    int maxStaff,
    double? hourlyRate,
  });
}

/// @nodoc
class _$CreateShiftRequestCopyWithImpl<$Res, $Val extends CreateShiftRequest>
    implements $CreateShiftRequestCopyWith<$Res> {
  _$CreateShiftRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? maxStaff = null,
    Object? hourlyRate = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxStaff: null == maxStaff
                ? _value.maxStaff
                : maxStaff // ignore: cast_nullable_to_non_nullable
                      as int,
            hourlyRate: freezed == hourlyRate
                ? _value.hourlyRate
                : hourlyRate // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateShiftRequestImplCopyWith<$Res>
    implements $CreateShiftRequestCopyWith<$Res> {
  factory _$$CreateShiftRequestImplCopyWith(
    _$CreateShiftRequestImpl value,
    $Res Function(_$CreateShiftRequestImpl) then,
  ) = __$$CreateShiftRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? description,
    DateTime startTime,
    DateTime endTime,
    String? location,
    int maxStaff,
    double? hourlyRate,
  });
}

/// @nodoc
class __$$CreateShiftRequestImplCopyWithImpl<$Res>
    extends _$CreateShiftRequestCopyWithImpl<$Res, _$CreateShiftRequestImpl>
    implements _$$CreateShiftRequestImplCopyWith<$Res> {
  __$$CreateShiftRequestImplCopyWithImpl(
    _$CreateShiftRequestImpl _value,
    $Res Function(_$CreateShiftRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? maxStaff = null,
    Object? hourlyRate = freezed,
  }) {
    return _then(
      _$CreateShiftRequestImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxStaff: null == maxStaff
            ? _value.maxStaff
            : maxStaff // ignore: cast_nullable_to_non_nullable
                  as int,
        hourlyRate: freezed == hourlyRate
            ? _value.hourlyRate
            : hourlyRate // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateShiftRequestImpl implements _CreateShiftRequest {
  const _$CreateShiftRequestImpl({
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.location,
    this.maxStaff = 1,
    this.hourlyRate,
  });

  factory _$CreateShiftRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateShiftRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String? location;
  @override
  @JsonKey()
  final int maxStaff;
  @override
  final double? hourlyRate;

  @override
  String toString() {
    return 'CreateShiftRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, maxStaff: $maxStaff, hourlyRate: $hourlyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateShiftRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.maxStaff, maxStaff) ||
                other.maxStaff == maxStaff) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    startTime,
    endTime,
    location,
    maxStaff,
    hourlyRate,
  );

  /// Create a copy of CreateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateShiftRequestImplCopyWith<_$CreateShiftRequestImpl> get copyWith =>
      __$$CreateShiftRequestImplCopyWithImpl<_$CreateShiftRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateShiftRequestImplToJson(this);
  }
}

abstract class _CreateShiftRequest implements CreateShiftRequest {
  const factory _CreateShiftRequest({
    required final String title,
    final String? description,
    required final DateTime startTime,
    required final DateTime endTime,
    final String? location,
    final int maxStaff,
    final double? hourlyRate,
  }) = _$CreateShiftRequestImpl;

  factory _CreateShiftRequest.fromJson(Map<String, dynamic> json) =
      _$CreateShiftRequestImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String? get location;
  @override
  int get maxStaff;
  @override
  double? get hourlyRate;

  /// Create a copy of CreateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateShiftRequestImplCopyWith<_$CreateShiftRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateShiftRequest _$UpdateShiftRequestFromJson(Map<String, dynamic> json) {
  return _UpdateShiftRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateShiftRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int? get maxStaff => throw _privateConstructorUsedError;
  double? get hourlyRate => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this UpdateShiftRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateShiftRequestCopyWith<UpdateShiftRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateShiftRequestCopyWith<$Res> {
  factory $UpdateShiftRequestCopyWith(
    UpdateShiftRequest value,
    $Res Function(UpdateShiftRequest) then,
  ) = _$UpdateShiftRequestCopyWithImpl<$Res, UpdateShiftRequest>;
  @useResult
  $Res call({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    int? maxStaff,
    double? hourlyRate,
    bool? isActive,
  });
}

/// @nodoc
class _$UpdateShiftRequestCopyWithImpl<$Res, $Val extends UpdateShiftRequest>
    implements $UpdateShiftRequestCopyWith<$Res> {
  _$UpdateShiftRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? location = freezed,
    Object? maxStaff = freezed,
    Object? hourlyRate = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxStaff: freezed == maxStaff
                ? _value.maxStaff
                : maxStaff // ignore: cast_nullable_to_non_nullable
                      as int?,
            hourlyRate: freezed == hourlyRate
                ? _value.hourlyRate
                : hourlyRate // ignore: cast_nullable_to_non_nullable
                      as double?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateShiftRequestImplCopyWith<$Res>
    implements $UpdateShiftRequestCopyWith<$Res> {
  factory _$$UpdateShiftRequestImplCopyWith(
    _$UpdateShiftRequestImpl value,
    $Res Function(_$UpdateShiftRequestImpl) then,
  ) = __$$UpdateShiftRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    int? maxStaff,
    double? hourlyRate,
    bool? isActive,
  });
}

/// @nodoc
class __$$UpdateShiftRequestImplCopyWithImpl<$Res>
    extends _$UpdateShiftRequestCopyWithImpl<$Res, _$UpdateShiftRequestImpl>
    implements _$$UpdateShiftRequestImplCopyWith<$Res> {
  __$$UpdateShiftRequestImplCopyWithImpl(
    _$UpdateShiftRequestImpl _value,
    $Res Function(_$UpdateShiftRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? location = freezed,
    Object? maxStaff = freezed,
    Object? hourlyRate = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _$UpdateShiftRequestImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: freezed == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxStaff: freezed == maxStaff
            ? _value.maxStaff
            : maxStaff // ignore: cast_nullable_to_non_nullable
                  as int?,
        hourlyRate: freezed == hourlyRate
            ? _value.hourlyRate
            : hourlyRate // ignore: cast_nullable_to_non_nullable
                  as double?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateShiftRequestImpl implements _UpdateShiftRequest {
  const _$UpdateShiftRequestImpl({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.location,
    this.maxStaff,
    this.hourlyRate,
    this.isActive,
  });

  factory _$UpdateShiftRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateShiftRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final String? location;
  @override
  final int? maxStaff;
  @override
  final double? hourlyRate;
  @override
  final bool? isActive;

  @override
  String toString() {
    return 'UpdateShiftRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, maxStaff: $maxStaff, hourlyRate: $hourlyRate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateShiftRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.maxStaff, maxStaff) ||
                other.maxStaff == maxStaff) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    startTime,
    endTime,
    location,
    maxStaff,
    hourlyRate,
    isActive,
  );

  /// Create a copy of UpdateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateShiftRequestImplCopyWith<_$UpdateShiftRequestImpl> get copyWith =>
      __$$UpdateShiftRequestImplCopyWithImpl<_$UpdateShiftRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateShiftRequestImplToJson(this);
  }
}

abstract class _UpdateShiftRequest implements UpdateShiftRequest {
  const factory _UpdateShiftRequest({
    final String? title,
    final String? description,
    final DateTime? startTime,
    final DateTime? endTime,
    final String? location,
    final int? maxStaff,
    final double? hourlyRate,
    final bool? isActive,
  }) = _$UpdateShiftRequestImpl;

  factory _UpdateShiftRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateShiftRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  String? get location;
  @override
  int? get maxStaff;
  @override
  double? get hourlyRate;
  @override
  bool? get isActive;

  /// Create a copy of UpdateShiftRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateShiftRequestImplCopyWith<_$UpdateShiftRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
