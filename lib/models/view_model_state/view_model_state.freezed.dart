// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ViewModelStateTearOff {
  const _$ViewModelStateTearOff();

  _Idle idle() {
    return const _Idle();
  }

  _Error error(ApiFailure failure) {
    return _Error(
      failure,
    );
  }

  _Busy busy() {
    return const _Busy();
  }
}

/// @nodoc     ╷ 689 │     version: "0.4.8"
const $ViewModelState = _$ViewModelStateTearOff();

/// @nodoc
mixin _$ViewModelState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(ApiFailure failure) error,
    required TResult Function() busy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Error value) error,
    required TResult Function(_Busy value) busy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewModelStateCopyWith<$Res> {
  factory $ViewModelStateCopyWith(ViewModelState value, $Res Function(ViewModelState) then) =
      _$ViewModelStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ViewModelStateCopyWithImpl<$Res> implements $ViewModelStateCopyWith<$Res> {
  _$ViewModelStateCopyWithImpl(this._value, this._then);

  final ViewModelState _value;
  // ignore: unused_field
  final $Res Function(ViewModelState) _then;
}

/// @nodoc
abstract class _$IdleCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) then) = __$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class __$IdleCopyWithImpl<$Res> extends _$ViewModelStateCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(_Idle _value, $Res Function(_Idle) _then)
      : super(_value, (v) => _then(v as _Idle));

  @override
  _Idle get _value => super._value as _Idle;
}

/// @nodoc

class _$_Idle implements _Idle {
  const _$_Idle();

  @override
  String toString() {
    return 'ViewModelState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(ApiFailure failure) error,
    required TResult Function() busy,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Error value) error,
    required TResult Function(_Busy value) busy,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements ViewModelState {
  const factory _Idle() = _$_Idle;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) = __$ErrorCopyWithImpl<$Res>;
  $Res call({ApiFailure failure});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$ViewModelStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_Error(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as ApiFailure,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.failure);

  @override
  final ApiFailure failure;

  @override
  String toString() {
    return 'ViewModelState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(ApiFailure failure) error,
    required TResult Function() busy,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Error value) error,
    required TResult Function(_Busy value) busy,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ViewModelState {
  const factory _Error(ApiFailure failure) = _$_Error;

  ApiFailure get failure;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BusyCopyWith<$Res> {
  factory _$BusyCopyWith(_Busy value, $Res Function(_Busy) then) = __$BusyCopyWithImpl<$Res>;
}

/// @nodoc
class __$BusyCopyWithImpl<$Res> extends _$ViewModelStateCopyWithImpl<$Res>
    implements _$BusyCopyWith<$Res> {
  __$BusyCopyWithImpl(_Busy _value, $Res Function(_Busy) _then)
      : super(_value, (v) => _then(v as _Busy));

  @override
  _Busy get _value => super._value as _Busy;
}

/// @nodoc

class _$_Busy implements _Busy {
  const _$_Busy();

  @override
  String toString() {
    return 'ViewModelState.busy()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Busy);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(ApiFailure failure) error,
    required TResult Function() busy,
  }) {
    return busy();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
  }) {
    return busy?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(ApiFailure failure)? error,
    TResult Function()? busy,
    required TResult orElse(),
  }) {
    if (busy != null) {
      return busy();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Error value) error,
    required TResult Function(_Busy value) busy,
  }) {
    return busy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
  }) {
    return busy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Error value)? error,
    TResult Function(_Busy value)? busy,
    required TResult orElse(),
  }) {
    if (busy != null) {
      return busy(this);
    }
    return orElse();
  }
}

abstract class _Busy implements ViewModelState {
  const factory _Busy() = _$_Busy;
}
