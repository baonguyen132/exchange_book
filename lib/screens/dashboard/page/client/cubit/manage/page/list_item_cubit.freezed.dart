// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_item_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListItemState {
  List<dynamic> get listItem => throw _privateConstructorUsedError;
  bool get stateClick => throw _privateConstructorUsedError;
  String get stateItem => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<dynamic> listItem, bool stateClick, String stateItem)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<dynamic> listItem, bool stateClick, String stateItem)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<dynamic> listItem, bool stateClick, String stateItem)?
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

  /// Create a copy of ListItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListItemStateCopyWith<ListItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListItemStateCopyWith<$Res> {
  factory $ListItemStateCopyWith(
          ListItemState value, $Res Function(ListItemState) then) =
      _$ListItemStateCopyWithImpl<$Res, ListItemState>;
  @useResult
  $Res call({List<dynamic> listItem, bool stateClick, String stateItem});
}

/// @nodoc
class _$ListItemStateCopyWithImpl<$Res, $Val extends ListItemState>
    implements $ListItemStateCopyWith<$Res> {
  _$ListItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listItem = null,
    Object? stateClick = null,
    Object? stateItem = null,
  }) {
    return _then(_value.copyWith(
      listItem: null == listItem
          ? _value.listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      stateClick: null == stateClick
          ? _value.stateClick
          : stateClick // ignore: cast_nullable_to_non_nullable
              as bool,
      stateItem: null == stateItem
          ? _value.stateItem
          : stateItem // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ListItemStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic> listItem, bool stateClick, String stateItem});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ListItemStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listItem = null,
    Object? stateClick = null,
    Object? stateItem = null,
  }) {
    return _then(_$InitialImpl(
      listItem: null == listItem
          ? _value._listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      stateClick: null == stateClick
          ? _value.stateClick
          : stateClick // ignore: cast_nullable_to_non_nullable
              as bool,
      stateItem: null == stateItem
          ? _value.stateItem
          : stateItem // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required final List<dynamic> listItem,
      required this.stateClick,
      required this.stateItem})
      : _listItem = listItem;

  final List<dynamic> _listItem;
  @override
  List<dynamic> get listItem {
    if (_listItem is EqualUnmodifiableListView) return _listItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItem);
  }

  @override
  final bool stateClick;
  @override
  final String stateItem;

  @override
  String toString() {
    return 'ListItemState.initial(listItem: $listItem, stateClick: $stateClick, stateItem: $stateItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(other._listItem, _listItem) &&
            (identical(other.stateClick, stateClick) ||
                other.stateClick == stateClick) &&
            (identical(other.stateItem, stateItem) ||
                other.stateItem == stateItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_listItem), stateClick, stateItem);

  /// Create a copy of ListItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<dynamic> listItem, bool stateClick, String stateItem)
        initial,
  }) {
    return initial(listItem, stateClick, stateItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<dynamic> listItem, bool stateClick, String stateItem)?
        initial,
  }) {
    return initial?.call(listItem, stateClick, stateItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<dynamic> listItem, bool stateClick, String stateItem)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(listItem, stateClick, stateItem);
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

abstract class _Initial implements ListItemState {
  const factory _Initial(
      {required final List<dynamic> listItem,
      required final bool stateClick,
      required final String stateItem}) = _$InitialImpl;

  @override
  List<dynamic> get listItem;
  @override
  bool get stateClick;
  @override
  String get stateItem;

  /// Create a copy of ListItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
