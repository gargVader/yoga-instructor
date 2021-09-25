// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'retrieve_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RetrieveUserStateTearOff {
  const _$RetrieveUserStateTearOff();

  InitialUserData call() {
    return const InitialUserData();
  }

  RetrievingUser retrieving() {
    return const RetrievingUser();
  }

  RetrievedUser retrieved(MyUser user, List<Attempt> attempts) {
    return RetrievedUser(
      user,
      attempts,
    );
  }

  RetrievedUserAccuracy hasAccuracyData(MyUser user, List<Attempt> attempts) {
    return RetrievedUserAccuracy(
      user,
      attempts,
    );
  }

  ErrorRetrievingUser error({String? message}) {
    return ErrorRetrievingUser(
      message: message,
    );
  }
}

/// @nodoc
const $RetrieveUserState = _$RetrieveUserStateTearOff();

/// @nodoc
mixin _$RetrieveUserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrieveUserStateCopyWith<$Res> {
  factory $RetrieveUserStateCopyWith(
          RetrieveUserState value, $Res Function(RetrieveUserState) then) =
      _$RetrieveUserStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrieveUserStateCopyWithImpl<$Res>
    implements $RetrieveUserStateCopyWith<$Res> {
  _$RetrieveUserStateCopyWithImpl(this._value, this._then);

  final RetrieveUserState _value;
  // ignore: unused_field
  final $Res Function(RetrieveUserState) _then;
}

/// @nodoc
abstract class $InitialUserDataCopyWith<$Res> {
  factory $InitialUserDataCopyWith(
          InitialUserData value, $Res Function(InitialUserData) then) =
      _$InitialUserDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialUserDataCopyWithImpl<$Res>
    extends _$RetrieveUserStateCopyWithImpl<$Res>
    implements $InitialUserDataCopyWith<$Res> {
  _$InitialUserDataCopyWithImpl(
      InitialUserData _value, $Res Function(InitialUserData) _then)
      : super(_value, (v) => _then(v as InitialUserData));

  @override
  InitialUserData get _value => super._value as InitialUserData;
}

/// @nodoc

class _$InitialUserData implements InitialUserData {
  const _$InitialUserData();

  @override
  String toString() {
    return 'RetrieveUserState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialUserData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
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
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialUserData implements RetrieveUserState {
  const factory InitialUserData() = _$InitialUserData;
}

/// @nodoc
abstract class $RetrievingUserCopyWith<$Res> {
  factory $RetrievingUserCopyWith(
          RetrievingUser value, $Res Function(RetrievingUser) then) =
      _$RetrievingUserCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievingUserCopyWithImpl<$Res>
    extends _$RetrieveUserStateCopyWithImpl<$Res>
    implements $RetrievingUserCopyWith<$Res> {
  _$RetrievingUserCopyWithImpl(
      RetrievingUser _value, $Res Function(RetrievingUser) _then)
      : super(_value, (v) => _then(v as RetrievingUser));

  @override
  RetrievingUser get _value => super._value as RetrievingUser;
}

/// @nodoc

class _$RetrievingUser implements RetrievingUser {
  const _$RetrievingUser();

  @override
  String toString() {
    return 'RetrieveUserState.retrieving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RetrievingUser);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) {
    return retrieving();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
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
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) {
    return retrieving(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) {
    if (retrieving != null) {
      return retrieving(this);
    }
    return orElse();
  }
}

abstract class RetrievingUser implements RetrieveUserState {
  const factory RetrievingUser() = _$RetrievingUser;
}

/// @nodoc
abstract class $RetrievedUserCopyWith<$Res> {
  factory $RetrievedUserCopyWith(
          RetrievedUser value, $Res Function(RetrievedUser) then) =
      _$RetrievedUserCopyWithImpl<$Res>;
  $Res call({MyUser user, List<Attempt> attempts});
}

/// @nodoc
class _$RetrievedUserCopyWithImpl<$Res>
    extends _$RetrieveUserStateCopyWithImpl<$Res>
    implements $RetrievedUserCopyWith<$Res> {
  _$RetrievedUserCopyWithImpl(
      RetrievedUser _value, $Res Function(RetrievedUser) _then)
      : super(_value, (v) => _then(v as RetrievedUser));

  @override
  RetrievedUser get _value => super._value as RetrievedUser;

  @override
  $Res call({
    Object? user = freezed,
    Object? attempts = freezed,
  }) {
    return _then(RetrievedUser(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as MyUser,
      attempts == freezed
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<Attempt>,
    ));
  }
}

/// @nodoc

class _$RetrievedUser implements RetrievedUser {
  const _$RetrievedUser(this.user, this.attempts);

  @override
  final MyUser user;
  @override
  final List<Attempt> attempts;

  @override
  String toString() {
    return 'RetrieveUserState.retrieved(user: $user, attempts: $attempts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedUser &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.attempts, attempts) ||
                const DeepCollectionEquality()
                    .equals(other.attempts, attempts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(attempts);

  @JsonKey(ignore: true)
  @override
  $RetrievedUserCopyWith<RetrievedUser> get copyWith =>
      _$RetrievedUserCopyWithImpl<RetrievedUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) {
    return retrieved(user, attempts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(user, attempts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) {
    return retrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(this);
    }
    return orElse();
  }
}

abstract class RetrievedUser implements RetrieveUserState {
  const factory RetrievedUser(MyUser user, List<Attempt> attempts) =
      _$RetrievedUser;

  MyUser get user => throw _privateConstructorUsedError;
  List<Attempt> get attempts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetrievedUserCopyWith<RetrievedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrievedUserAccuracyCopyWith<$Res> {
  factory $RetrievedUserAccuracyCopyWith(RetrievedUserAccuracy value,
          $Res Function(RetrievedUserAccuracy) then) =
      _$RetrievedUserAccuracyCopyWithImpl<$Res>;
  $Res call({MyUser user, List<Attempt> attempts});
}

/// @nodoc
class _$RetrievedUserAccuracyCopyWithImpl<$Res>
    extends _$RetrieveUserStateCopyWithImpl<$Res>
    implements $RetrievedUserAccuracyCopyWith<$Res> {
  _$RetrievedUserAccuracyCopyWithImpl(
      RetrievedUserAccuracy _value, $Res Function(RetrievedUserAccuracy) _then)
      : super(_value, (v) => _then(v as RetrievedUserAccuracy));

  @override
  RetrievedUserAccuracy get _value => super._value as RetrievedUserAccuracy;

  @override
  $Res call({
    Object? user = freezed,
    Object? attempts = freezed,
  }) {
    return _then(RetrievedUserAccuracy(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as MyUser,
      attempts == freezed
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<Attempt>,
    ));
  }
}

/// @nodoc

class _$RetrievedUserAccuracy implements RetrievedUserAccuracy {
  const _$RetrievedUserAccuracy(this.user, this.attempts);

  @override
  final MyUser user;
  @override
  final List<Attempt> attempts;

  @override
  String toString() {
    return 'RetrieveUserState.hasAccuracyData(user: $user, attempts: $attempts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedUserAccuracy &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.attempts, attempts) ||
                const DeepCollectionEquality()
                    .equals(other.attempts, attempts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(attempts);

  @JsonKey(ignore: true)
  @override
  $RetrievedUserAccuracyCopyWith<RetrievedUserAccuracy> get copyWith =>
      _$RetrievedUserAccuracyCopyWithImpl<RetrievedUserAccuracy>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) {
    return hasAccuracyData(user, attempts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (hasAccuracyData != null) {
      return hasAccuracyData(user, attempts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) {
    return hasAccuracyData(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) {
    if (hasAccuracyData != null) {
      return hasAccuracyData(this);
    }
    return orElse();
  }
}

abstract class RetrievedUserAccuracy implements RetrieveUserState {
  const factory RetrievedUserAccuracy(MyUser user, List<Attempt> attempts) =
      _$RetrievedUserAccuracy;

  MyUser get user => throw _privateConstructorUsedError;
  List<Attempt> get attempts => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetrievedUserAccuracyCopyWith<RetrievedUserAccuracy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorRetrievingUserCopyWith<$Res> {
  factory $ErrorRetrievingUserCopyWith(
          ErrorRetrievingUser value, $Res Function(ErrorRetrievingUser) then) =
      _$ErrorRetrievingUserCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$ErrorRetrievingUserCopyWithImpl<$Res>
    extends _$RetrieveUserStateCopyWithImpl<$Res>
    implements $ErrorRetrievingUserCopyWith<$Res> {
  _$ErrorRetrievingUserCopyWithImpl(
      ErrorRetrievingUser _value, $Res Function(ErrorRetrievingUser) _then)
      : super(_value, (v) => _then(v as ErrorRetrievingUser));

  @override
  ErrorRetrievingUser get _value => super._value as ErrorRetrievingUser;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorRetrievingUser(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorRetrievingUser implements ErrorRetrievingUser {
  const _$ErrorRetrievingUser({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RetrieveUserState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorRetrievingUser &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorRetrievingUserCopyWith<ErrorRetrievingUser> get copyWith =>
      _$ErrorRetrievingUserCopyWithImpl<ErrorRetrievingUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(MyUser user, List<Attempt> attempts) retrieved,
    required TResult Function(MyUser user, List<Attempt> attempts)
        hasAccuracyData,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(MyUser user, List<Attempt> attempts)? retrieved,
    TResult Function(MyUser user, List<Attempt> attempts)? hasAccuracyData,
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
    TResult Function(InitialUserData value) $default, {
    required TResult Function(RetrievingUser value) retrieving,
    required TResult Function(RetrievedUser value) retrieved,
    required TResult Function(RetrievedUserAccuracy value) hasAccuracyData,
    required TResult Function(ErrorRetrievingUser value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialUserData value)? $default, {
    TResult Function(RetrievingUser value)? retrieving,
    TResult Function(RetrievedUser value)? retrieved,
    TResult Function(RetrievedUserAccuracy value)? hasAccuracyData,
    TResult Function(ErrorRetrievingUser value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorRetrievingUser implements RetrieveUserState {
  const factory ErrorRetrievingUser({String? message}) = _$ErrorRetrievingUser;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorRetrievingUserCopyWith<ErrorRetrievingUser> get copyWith =>
      throw _privateConstructorUsedError;
}
