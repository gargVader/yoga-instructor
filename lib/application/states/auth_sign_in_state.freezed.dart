// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'auth_sign_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthSignInStateTearOff {
  const _$AuthSignInStateTearOff();

  Initial call() {
    return const Initial();
  }

  SigningIn signingIn() {
    return const SigningIn();
  }

  SignedIn signedIn(User user) {
    return SignedIn(
      user,
    );
  }

  SignInError error({String? message}) {
    return SignInError(
      message: message,
    );
  }
}

/// @nodoc
const $AuthSignInState = _$AuthSignInStateTearOff();

/// @nodoc
mixin _$AuthSignInState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() signingIn,
    required TResult Function(User user) signedIn,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? signingIn,
    TResult Function(User user)? signedIn,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(SigningIn value) signingIn,
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignInError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(SigningIn value)? signingIn,
    TResult Function(SignedIn value)? signedIn,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSignInStateCopyWith<$Res> {
  factory $AuthSignInStateCopyWith(
          AuthSignInState value, $Res Function(AuthSignInState) then) =
      _$AuthSignInStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthSignInStateCopyWithImpl<$Res>
    implements $AuthSignInStateCopyWith<$Res> {
  _$AuthSignInStateCopyWithImpl(this._value, this._then);

  final AuthSignInState _value;
  // ignore: unused_field
  final $Res Function(AuthSignInState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$AuthSignInStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'AuthSignInState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() signingIn,
    required TResult Function(User user) signedIn,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? signingIn,
    TResult Function(User user)? signedIn,
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
    TResult Function(Initial value) $default, {
    required TResult Function(SigningIn value) signingIn,
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignInError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(SigningIn value)? signingIn,
    TResult Function(SignedIn value)? signedIn,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Initial implements AuthSignInState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class $SigningInCopyWith<$Res> {
  factory $SigningInCopyWith(SigningIn value, $Res Function(SigningIn) then) =
      _$SigningInCopyWithImpl<$Res>;
}

/// @nodoc
class _$SigningInCopyWithImpl<$Res> extends _$AuthSignInStateCopyWithImpl<$Res>
    implements $SigningInCopyWith<$Res> {
  _$SigningInCopyWithImpl(SigningIn _value, $Res Function(SigningIn) _then)
      : super(_value, (v) => _then(v as SigningIn));

  @override
  SigningIn get _value => super._value as SigningIn;
}

/// @nodoc

class _$SigningIn implements SigningIn {
  const _$SigningIn();

  @override
  String toString() {
    return 'AuthSignInState.signingIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SigningIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() signingIn,
    required TResult Function(User user) signedIn,
    required TResult Function(String? message) error,
  }) {
    return signingIn();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? signingIn,
    TResult Function(User user)? signedIn,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (signingIn != null) {
      return signingIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(SigningIn value) signingIn,
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignInError value) error,
  }) {
    return signingIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(SigningIn value)? signingIn,
    TResult Function(SignedIn value)? signedIn,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (signingIn != null) {
      return signingIn(this);
    }
    return orElse();
  }
}

abstract class SigningIn implements AuthSignInState {
  const factory SigningIn() = _$SigningIn;
}

/// @nodoc
abstract class $SignedInCopyWith<$Res> {
  factory $SignedInCopyWith(SignedIn value, $Res Function(SignedIn) then) =
      _$SignedInCopyWithImpl<$Res>;
  $Res call({User user});
}

/// @nodoc
class _$SignedInCopyWithImpl<$Res> extends _$AuthSignInStateCopyWithImpl<$Res>
    implements $SignedInCopyWith<$Res> {
  _$SignedInCopyWithImpl(SignedIn _value, $Res Function(SignedIn) _then)
      : super(_value, (v) => _then(v as SignedIn));

  @override
  SignedIn get _value => super._value as SignedIn;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(SignedIn(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$SignedIn implements SignedIn {
  const _$SignedIn(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthSignInState.signedIn(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SignedIn &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $SignedInCopyWith<SignedIn> get copyWith =>
      _$SignedInCopyWithImpl<SignedIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() signingIn,
    required TResult Function(User user) signedIn,
    required TResult Function(String? message) error,
  }) {
    return signedIn(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? signingIn,
    TResult Function(User user)? signedIn,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(SigningIn value) signingIn,
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignInError value) error,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(SigningIn value)? signingIn,
    TResult Function(SignedIn value)? signedIn,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class SignedIn implements AuthSignInState {
  const factory SignedIn(User user) = _$SignedIn;

  User get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignedInCopyWith<SignedIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInErrorCopyWith<$Res> {
  factory $SignInErrorCopyWith(
          SignInError value, $Res Function(SignInError) then) =
      _$SignInErrorCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$SignInErrorCopyWithImpl<$Res>
    extends _$AuthSignInStateCopyWithImpl<$Res>
    implements $SignInErrorCopyWith<$Res> {
  _$SignInErrorCopyWithImpl(
      SignInError _value, $Res Function(SignInError) _then)
      : super(_value, (v) => _then(v as SignInError));

  @override
  SignInError get _value => super._value as SignInError;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(SignInError(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignInError implements SignInError {
  const _$SignInError({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthSignInState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SignInError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $SignInErrorCopyWith<SignInError> get copyWith =>
      _$SignInErrorCopyWithImpl<SignInError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() signingIn,
    required TResult Function(User user) signedIn,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? signingIn,
    TResult Function(User user)? signedIn,
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
    TResult Function(Initial value) $default, {
    required TResult Function(SigningIn value) signingIn,
    required TResult Function(SignedIn value) signedIn,
    required TResult Function(SignInError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(SigningIn value)? signingIn,
    TResult Function(SignedIn value)? signedIn,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SignInError implements AuthSignInState {
  const factory SignInError({String? message}) = _$SignInError;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignInErrorCopyWith<SignInError> get copyWith =>
      throw _privateConstructorUsedError;
}
