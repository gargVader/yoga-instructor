// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'retrieve_attempts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RetrieveAttemptsStateTearOff {
  const _$RetrieveAttemptsStateTearOff();

  InitialAttemptData call() {
    return const InitialAttemptData();
  }

  RetrievingAttempts retrieving() {
    return const RetrievingAttempts();
  }

  RetrievedAttempts retrieved(List<Attempt> attempts) {
    return RetrievedAttempts(
      attempts,
    );
  }

  ErrorRetrievingAttempts error({String? message}) {
    return ErrorRetrievingAttempts(
      message: message,
    );
  }
}

/// @nodoc
const $RetrieveAttemptsState = _$RetrieveAttemptsStateTearOff();

/// @nodoc
mixin _$RetrieveAttemptsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Attempt> attempts) retrieved,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Attempt> attempts)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialAttemptData value) $default, {
    required TResult Function(RetrievingAttempts value) retrieving,
    required TResult Function(RetrievedAttempts value) retrieved,
    required TResult Function(ErrorRetrievingAttempts value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialAttemptData value)? $default, {
    TResult Function(RetrievingAttempts value)? retrieving,
    TResult Function(RetrievedAttempts value)? retrieved,
    TResult Function(ErrorRetrievingAttempts value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrieveAttemptsStateCopyWith<$Res> {
  factory $RetrieveAttemptsStateCopyWith(RetrieveAttemptsState value,
          $Res Function(RetrieveAttemptsState) then) =
      _$RetrieveAttemptsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrieveAttemptsStateCopyWithImpl<$Res>
    implements $RetrieveAttemptsStateCopyWith<$Res> {
  _$RetrieveAttemptsStateCopyWithImpl(this._value, this._then);

  final RetrieveAttemptsState _value;
  // ignore: unused_field
  final $Res Function(RetrieveAttemptsState) _then;
}

/// @nodoc
abstract class $InitialAttemptDataCopyWith<$Res> {
  factory $InitialAttemptDataCopyWith(
          InitialAttemptData value, $Res Function(InitialAttemptData) then) =
      _$InitialAttemptDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialAttemptDataCopyWithImpl<$Res>
    extends _$RetrieveAttemptsStateCopyWithImpl<$Res>
    implements $InitialAttemptDataCopyWith<$Res> {
  _$InitialAttemptDataCopyWithImpl(
      InitialAttemptData _value, $Res Function(InitialAttemptData) _then)
      : super(_value, (v) => _then(v as InitialAttemptData));

  @override
  InitialAttemptData get _value => super._value as InitialAttemptData;
}

/// @nodoc

class _$InitialAttemptData implements InitialAttemptData {
  const _$InitialAttemptData();

  @override
  String toString() {
    return 'RetrieveAttemptsState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialAttemptData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Attempt> attempts) retrieved,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Attempt> attempts)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialAttemptData value) $default, {
    required TResult Function(RetrievingAttempts value) retrieving,
    required TResult Function(RetrievedAttempts value) retrieved,
    required TResult Function(ErrorRetrievingAttempts value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialAttemptData value)? $default, {
    TResult Function(RetrievingAttempts value)? retrieving,
    TResult Function(RetrievedAttempts value)? retrieved,
    TResult Function(ErrorRetrievingAttempts value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialAttemptData implements RetrieveAttemptsState {
  const factory InitialAttemptData() = _$InitialAttemptData;
}

/// @nodoc
abstract class $RetrievingAttemptsCopyWith<$Res> {
  factory $RetrievingAttemptsCopyWith(
          RetrievingAttempts value, $Res Function(RetrievingAttempts) then) =
      _$RetrievingAttemptsCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievingAttemptsCopyWithImpl<$Res>
    extends _$RetrieveAttemptsStateCopyWithImpl<$Res>
    implements $RetrievingAttemptsCopyWith<$Res> {
  _$RetrievingAttemptsCopyWithImpl(
      RetrievingAttempts _value, $Res Function(RetrievingAttempts) _then)
      : super(_value, (v) => _then(v as RetrievingAttempts));

  @override
  RetrievingAttempts get _value => super._value as RetrievingAttempts;
}

/// @nodoc

class _$RetrievingAttempts implements RetrievingAttempts {
  const _$RetrievingAttempts();

  @override
  String toString() {
    return 'RetrieveAttemptsState.retrieving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RetrievingAttempts);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Attempt> attempts) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieving();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Attempt> attempts)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (retrieving != null) {
      return retrieving();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialAttemptData value) $default, {
    required TResult Function(RetrievingAttempts value) retrieving,
    required TResult Function(RetrievedAttempts value) retrieved,
    required TResult Function(ErrorRetrievingAttempts value) error,
  }) {
    return retrieving(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialAttemptData value)? $default, {
    TResult Function(RetrievingAttempts value)? retrieving,
    TResult Function(RetrievedAttempts value)? retrieved,
    TResult Function(ErrorRetrievingAttempts value)? error,
    required TResult orElse(),
  }) {
    if (retrieving != null) {
      return retrieving(this);
    }
    return orElse();
  }
}

abstract class RetrievingAttempts implements RetrieveAttemptsState {
  const factory RetrievingAttempts() = _$RetrievingAttempts;
}

/// @nodoc
abstract class $RetrievedAttemptsCopyWith<$Res> {
  factory $RetrievedAttemptsCopyWith(
          RetrievedAttempts value, $Res Function(RetrievedAttempts) then) =
      _$RetrievedAttemptsCopyWithImpl<$Res>;
  $Res call({List<Attempt> attempts});
}

/// @nodoc
class _$RetrievedAttemptsCopyWithImpl<$Res>
    extends _$RetrieveAttemptsStateCopyWithImpl<$Res>
    implements $RetrievedAttemptsCopyWith<$Res> {
  _$RetrievedAttemptsCopyWithImpl(
      RetrievedAttempts _value, $Res Function(RetrievedAttempts) _then)
      : super(_value, (v) => _then(v as RetrievedAttempts));

  @override
  RetrievedAttempts get _value => super._value as RetrievedAttempts;

  @override
  $Res call({
    Object? attempts = freezed,
  }) {
    return _then(RetrievedAttempts(
      attempts == freezed
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<Attempt>,
    ));
  }
}

/// @nodoc

class _$RetrievedAttempts implements RetrievedAttempts {
  const _$RetrievedAttempts(this.attempts);

  @override
  final List<Attempt> attempts;

  @override
  String toString() {
    return 'RetrieveAttemptsState.retrieved(attempts: $attempts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedAttempts &&
            (identical(other.attempts, attempts) ||
                const DeepCollectionEquality()
                    .equals(other.attempts, attempts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(attempts);

  @JsonKey(ignore: true)
  @override
  $RetrievedAttemptsCopyWith<RetrievedAttempts> get copyWith =>
      _$RetrievedAttemptsCopyWithImpl<RetrievedAttempts>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Attempt> attempts) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieved(attempts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Attempt> attempts)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(attempts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialAttemptData value) $default, {
    required TResult Function(RetrievingAttempts value) retrieving,
    required TResult Function(RetrievedAttempts value) retrieved,
    required TResult Function(ErrorRetrievingAttempts value) error,
  }) {
    return retrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialAttemptData value)? $default, {
    TResult Function(RetrievingAttempts value)? retrieving,
    TResult Function(RetrievedAttempts value)? retrieved,
    TResult Function(ErrorRetrievingAttempts value)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(this);
    }
    return orElse();
  }
}

abstract class RetrievedAttempts implements RetrieveAttemptsState {
  const factory RetrievedAttempts(List<Attempt> attempts) = _$RetrievedAttempts;

  List<Attempt> get attempts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetrievedAttemptsCopyWith<RetrievedAttempts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorRetrievingAttemptsCopyWith<$Res> {
  factory $ErrorRetrievingAttemptsCopyWith(ErrorRetrievingAttempts value,
          $Res Function(ErrorRetrievingAttempts) then) =
      _$ErrorRetrievingAttemptsCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$ErrorRetrievingAttemptsCopyWithImpl<$Res>
    extends _$RetrieveAttemptsStateCopyWithImpl<$Res>
    implements $ErrorRetrievingAttemptsCopyWith<$Res> {
  _$ErrorRetrievingAttemptsCopyWithImpl(ErrorRetrievingAttempts _value,
      $Res Function(ErrorRetrievingAttempts) _then)
      : super(_value, (v) => _then(v as ErrorRetrievingAttempts));

  @override
  ErrorRetrievingAttempts get _value => super._value as ErrorRetrievingAttempts;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorRetrievingAttempts(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorRetrievingAttempts implements ErrorRetrievingAttempts {
  const _$ErrorRetrievingAttempts({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RetrieveAttemptsState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorRetrievingAttempts &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorRetrievingAttemptsCopyWith<ErrorRetrievingAttempts> get copyWith =>
      _$ErrorRetrievingAttemptsCopyWithImpl<ErrorRetrievingAttempts>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Attempt> attempts) retrieved,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Attempt> attempts)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialAttemptData value) $default, {
    required TResult Function(RetrievingAttempts value) retrieving,
    required TResult Function(RetrievedAttempts value) retrieved,
    required TResult Function(ErrorRetrievingAttempts value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialAttemptData value)? $default, {
    TResult Function(RetrievingAttempts value)? retrieving,
    TResult Function(RetrievedAttempts value)? retrieved,
    TResult Function(ErrorRetrievingAttempts value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorRetrievingAttempts implements RetrieveAttemptsState {
  const factory ErrorRetrievingAttempts({String? message}) =
      _$ErrorRetrievingAttempts;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorRetrievingAttemptsCopyWith<ErrorRetrievingAttempts> get copyWith =>
      throw _privateConstructorUsedError;
}
