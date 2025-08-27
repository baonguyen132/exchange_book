// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_point_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddPointState {
  String get idPurchasePoint => throw _privateConstructorUsedError;
  int get amout => throw _privateConstructorUsedError;
  String get errorAmout => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idPurchasePoint, int amout,
            String errorAmout, String path, UserModel user)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idPurchasePoint, int amout, String errorAmout,
            String path, UserModel user)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idPurchasePoint, int amout, String errorAmout,
            String path, UserModel user)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddPointState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddPointStateCopyWith<AddPointState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPointStateCopyWith<$Res> {
  factory $AddPointStateCopyWith(
          AddPointState value, $Res Function(AddPointState) then) =
      _$AddPointStateCopyWithImpl<$Res, AddPointState>;
  @useResult
  $Res call(
      {String idPurchasePoint,
      int amout,
      String errorAmout,
      String path,
      UserModel user});
}

/// @nodoc
class _$AddPointStateCopyWithImpl<$Res, $Val extends AddPointState>
    implements $AddPointStateCopyWith<$Res> {
  _$AddPointStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddPointState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPurchasePoint = null,
    Object? amout = null,
    Object? errorAmout = null,
    Object? path = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      idPurchasePoint: null == idPurchasePoint
          ? _value.idPurchasePoint
          : idPurchasePoint // ignore: cast_nullable_to_non_nullable
              as String,
      amout: null == amout
          ? _value.amout
          : amout // ignore: cast_nullable_to_non_nullable
              as int,
      errorAmout: null == errorAmout
          ? _value.errorAmout
          : errorAmout // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $AddPointStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idPurchasePoint,
      int amout,
      String errorAmout,
      String path,
      UserModel user});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AddPointStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddPointState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPurchasePoint = null,
    Object? amout = null,
    Object? errorAmout = null,
    Object? path = null,
    Object? user = null,
  }) {
    return _then(_$InitialImpl(
      idPurchasePoint: null == idPurchasePoint
          ? _value.idPurchasePoint
          : idPurchasePoint // ignore: cast_nullable_to_non_nullable
              as String,
      amout: null == amout
          ? _value.amout
          : amout // ignore: cast_nullable_to_non_nullable
              as int,
      errorAmout: null == errorAmout
          ? _value.errorAmout
          : errorAmout // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.idPurchasePoint,
      required this.amout,
      required this.errorAmout,
      required this.path,
      required this.user});

  @override
  final String idPurchasePoint;
  @override
  final int amout;
  @override
  final String errorAmout;
  @override
  final String path;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'AddPointState.initial(idPurchasePoint: $idPurchasePoint, amout: $amout, errorAmout: $errorAmout, path: $path, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.idPurchasePoint, idPurchasePoint) ||
                other.idPurchasePoint == idPurchasePoint) &&
            (identical(other.amout, amout) || other.amout == amout) &&
            (identical(other.errorAmout, errorAmout) ||
                other.errorAmout == errorAmout) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, idPurchasePoint, amout, errorAmout, path, user);

  /// Create a copy of AddPointState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idPurchasePoint, int amout,
            String errorAmout, String path, UserModel user)
        initial,
  }) {
    return initial(idPurchasePoint, amout, errorAmout, path, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idPurchasePoint, int amout, String errorAmout,
            String path, UserModel user)?
        initial,
  }) {
    return initial?.call(idPurchasePoint, amout, errorAmout, path, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idPurchasePoint, int amout, String errorAmout,
            String path, UserModel user)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(idPurchasePoint, amout, errorAmout, path, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AddPointState {
  const factory _Initial(
      {required final String idPurchasePoint,
      required final int amout,
      required final String errorAmout,
      required final String path,
      required final UserModel user}) = _$InitialImpl;

  @override
  String get idPurchasePoint;
  @override
  int get amout;
  @override
  String get errorAmout;
  @override
  String get path;
  @override
  UserModel get user;

  /// Create a copy of AddPointState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
