// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'voice_listen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VoiceListenStateTearOff {
  const _$VoiceListenStateTearOff();

  Idle call() {
    return const Idle();
  }

  ListeningInitializing initializing() {
    return const ListeningInitializing();
  }

  ListeningInitialized initialized() {
    return const ListeningInitialized();
  }

  Listening listening() {
    return const Listening();
  }

  Recognized recognized({required String recognizedWords}) {
    return Recognized(
      recognizedWords: recognizedWords,
    );
  }

  ResponseComplete complete({DetectIntentResponse? response}) {
    return ResponseComplete(
      response: response,
    );
  }

  ResponseReceived response({required String responseString}) {
    return ResponseReceived(
      responseString: responseString,
    );
  }

  ListeningError error({String? message}) {
    return ListeningError(
      message: message,
    );
  }
}

/// @nodoc
const $VoiceListenState = _$VoiceListenStateTearOff();

/// @nodoc
mixin _$VoiceListenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceListenStateCopyWith<$Res> {
  factory $VoiceListenStateCopyWith(
          VoiceListenState value, $Res Function(VoiceListenState) then) =
      _$VoiceListenStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$VoiceListenStateCopyWithImpl<$Res>
    implements $VoiceListenStateCopyWith<$Res> {
  _$VoiceListenStateCopyWithImpl(this._value, this._then);

  final VoiceListenState _value;
  // ignore: unused_field
  final $Res Function(VoiceListenState) _then;
}

/// @nodoc
abstract class $IdleCopyWith<$Res> {
  factory $IdleCopyWith(Idle value, $Res Function(Idle) then) =
      _$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCopyWithImpl<$Res> extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $IdleCopyWith<$Res> {
  _$IdleCopyWithImpl(Idle _value, $Res Function(Idle) _then)
      : super(_value, (v) => _then(v as Idle));

  @override
  Idle get _value => super._value as Idle;
}

/// @nodoc

class _$Idle implements Idle {
  const _$Idle();

  @override
  String toString() {
    return 'VoiceListenState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
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
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Idle implements VoiceListenState {
  const factory Idle() = _$Idle;
}

/// @nodoc
abstract class $ListeningInitializingCopyWith<$Res> {
  factory $ListeningInitializingCopyWith(ListeningInitializing value,
          $Res Function(ListeningInitializing) then) =
      _$ListeningInitializingCopyWithImpl<$Res>;
}

/// @nodoc
class _$ListeningInitializingCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ListeningInitializingCopyWith<$Res> {
  _$ListeningInitializingCopyWithImpl(
      ListeningInitializing _value, $Res Function(ListeningInitializing) _then)
      : super(_value, (v) => _then(v as ListeningInitializing));

  @override
  ListeningInitializing get _value => super._value as ListeningInitializing;
}

/// @nodoc

class _$ListeningInitializing implements ListeningInitializing {
  const _$ListeningInitializing();

  @override
  String toString() {
    return 'VoiceListenState.initializing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ListeningInitializing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class ListeningInitializing implements VoiceListenState {
  const factory ListeningInitializing() = _$ListeningInitializing;
}

/// @nodoc
abstract class $ListeningInitializedCopyWith<$Res> {
  factory $ListeningInitializedCopyWith(ListeningInitialized value,
          $Res Function(ListeningInitialized) then) =
      _$ListeningInitializedCopyWithImpl<$Res>;
}

/// @nodoc
class _$ListeningInitializedCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ListeningInitializedCopyWith<$Res> {
  _$ListeningInitializedCopyWithImpl(
      ListeningInitialized _value, $Res Function(ListeningInitialized) _then)
      : super(_value, (v) => _then(v as ListeningInitialized));

  @override
  ListeningInitialized get _value => super._value as ListeningInitialized;
}

/// @nodoc

class _$ListeningInitialized implements ListeningInitialized {
  const _$ListeningInitialized();

  @override
  String toString() {
    return 'VoiceListenState.initialized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ListeningInitialized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class ListeningInitialized implements VoiceListenState {
  const factory ListeningInitialized() = _$ListeningInitialized;
}

/// @nodoc
abstract class $ListeningCopyWith<$Res> {
  factory $ListeningCopyWith(Listening value, $Res Function(Listening) then) =
      _$ListeningCopyWithImpl<$Res>;
}

/// @nodoc
class _$ListeningCopyWithImpl<$Res> extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ListeningCopyWith<$Res> {
  _$ListeningCopyWithImpl(Listening _value, $Res Function(Listening) _then)
      : super(_value, (v) => _then(v as Listening));

  @override
  Listening get _value => super._value as Listening;
}

/// @nodoc

class _$Listening implements Listening {
  const _$Listening();

  @override
  String toString() {
    return 'VoiceListenState.listening()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Listening);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return listening();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (listening != null) {
      return listening();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return listening(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (listening != null) {
      return listening(this);
    }
    return orElse();
  }
}

abstract class Listening implements VoiceListenState {
  const factory Listening() = _$Listening;
}

/// @nodoc
abstract class $RecognizedCopyWith<$Res> {
  factory $RecognizedCopyWith(
          Recognized value, $Res Function(Recognized) then) =
      _$RecognizedCopyWithImpl<$Res>;
  $Res call({String recognizedWords});
}

/// @nodoc
class _$RecognizedCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $RecognizedCopyWith<$Res> {
  _$RecognizedCopyWithImpl(Recognized _value, $Res Function(Recognized) _then)
      : super(_value, (v) => _then(v as Recognized));

  @override
  Recognized get _value => super._value as Recognized;

  @override
  $Res call({
    Object? recognizedWords = freezed,
  }) {
    return _then(Recognized(
      recognizedWords: recognizedWords == freezed
          ? _value.recognizedWords
          : recognizedWords // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Recognized implements Recognized {
  const _$Recognized({required this.recognizedWords});

  @override
  final String recognizedWords;

  @override
  String toString() {
    return 'VoiceListenState.recognized(recognizedWords: $recognizedWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Recognized &&
            (identical(other.recognizedWords, recognizedWords) ||
                const DeepCollectionEquality()
                    .equals(other.recognizedWords, recognizedWords)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(recognizedWords);

  @JsonKey(ignore: true)
  @override
  $RecognizedCopyWith<Recognized> get copyWith =>
      _$RecognizedCopyWithImpl<Recognized>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return recognized(recognizedWords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (recognized != null) {
      return recognized(recognizedWords);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return recognized(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (recognized != null) {
      return recognized(this);
    }
    return orElse();
  }
}

abstract class Recognized implements VoiceListenState {
  const factory Recognized({required String recognizedWords}) = _$Recognized;

  String get recognizedWords => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecognizedCopyWith<Recognized> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCompleteCopyWith<$Res> {
  factory $ResponseCompleteCopyWith(
          ResponseComplete value, $Res Function(ResponseComplete) then) =
      _$ResponseCompleteCopyWithImpl<$Res>;
  $Res call({DetectIntentResponse? response});
}

/// @nodoc
class _$ResponseCompleteCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ResponseCompleteCopyWith<$Res> {
  _$ResponseCompleteCopyWithImpl(
      ResponseComplete _value, $Res Function(ResponseComplete) _then)
      : super(_value, (v) => _then(v as ResponseComplete));

  @override
  ResponseComplete get _value => super._value as ResponseComplete;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(ResponseComplete(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as DetectIntentResponse?,
    ));
  }
}

/// @nodoc

class _$ResponseComplete implements ResponseComplete {
  const _$ResponseComplete({this.response});

  @override
  final DetectIntentResponse? response;

  @override
  String toString() {
    return 'VoiceListenState.complete(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResponseComplete &&
            (identical(other.response, response) ||
                const DeepCollectionEquality()
                    .equals(other.response, response)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(response);

  @JsonKey(ignore: true)
  @override
  $ResponseCompleteCopyWith<ResponseComplete> get copyWith =>
      _$ResponseCompleteCopyWithImpl<ResponseComplete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return complete(this.response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this.response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class ResponseComplete implements VoiceListenState {
  const factory ResponseComplete({DetectIntentResponse? response}) =
      _$ResponseComplete;

  DetectIntentResponse? get response => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseCompleteCopyWith<ResponseComplete> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseReceivedCopyWith<$Res> {
  factory $ResponseReceivedCopyWith(
          ResponseReceived value, $Res Function(ResponseReceived) then) =
      _$ResponseReceivedCopyWithImpl<$Res>;
  $Res call({String responseString});
}

/// @nodoc
class _$ResponseReceivedCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ResponseReceivedCopyWith<$Res> {
  _$ResponseReceivedCopyWithImpl(
      ResponseReceived _value, $Res Function(ResponseReceived) _then)
      : super(_value, (v) => _then(v as ResponseReceived));

  @override
  ResponseReceived get _value => super._value as ResponseReceived;

  @override
  $Res call({
    Object? responseString = freezed,
  }) {
    return _then(ResponseReceived(
      responseString: responseString == freezed
          ? _value.responseString
          : responseString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResponseReceived implements ResponseReceived {
  const _$ResponseReceived({required this.responseString});

  @override
  final String responseString;

  @override
  String toString() {
    return 'VoiceListenState.response(responseString: $responseString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResponseReceived &&
            (identical(other.responseString, responseString) ||
                const DeepCollectionEquality()
                    .equals(other.responseString, responseString)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(responseString);

  @JsonKey(ignore: true)
  @override
  $ResponseReceivedCopyWith<ResponseReceived> get copyWith =>
      _$ResponseReceivedCopyWithImpl<ResponseReceived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return response(responseString);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(responseString);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return response(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this);
    }
    return orElse();
  }
}

abstract class ResponseReceived implements VoiceListenState {
  const factory ResponseReceived({required String responseString}) =
      _$ResponseReceived;

  String get responseString => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseReceivedCopyWith<ResponseReceived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListeningErrorCopyWith<$Res> {
  factory $ListeningErrorCopyWith(
          ListeningError value, $Res Function(ListeningError) then) =
      _$ListeningErrorCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$ListeningErrorCopyWithImpl<$Res>
    extends _$VoiceListenStateCopyWithImpl<$Res>
    implements $ListeningErrorCopyWith<$Res> {
  _$ListeningErrorCopyWithImpl(
      ListeningError _value, $Res Function(ListeningError) _then)
      : super(_value, (v) => _then(v as ListeningError));

  @override
  ListeningError get _value => super._value as ListeningError;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ListeningError(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ListeningError implements ListeningError {
  const _$ListeningError({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'VoiceListenState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListeningError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ListeningErrorCopyWith<ListeningError> get copyWith =>
      _$ListeningErrorCopyWithImpl<ListeningError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() initializing,
    required TResult Function() initialized,
    required TResult Function() listening,
    required TResult Function(String recognizedWords) recognized,
    required TResult Function(DetectIntentResponse? response) complete,
    required TResult Function(String responseString) response,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? initializing,
    TResult Function()? initialized,
    TResult Function()? listening,
    TResult Function(String recognizedWords)? recognized,
    TResult Function(DetectIntentResponse? response)? complete,
    TResult Function(String responseString)? response,
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
    TResult Function(Idle value) $default, {
    required TResult Function(ListeningInitializing value) initializing,
    required TResult Function(ListeningInitialized value) initialized,
    required TResult Function(Listening value) listening,
    required TResult Function(Recognized value) recognized,
    required TResult Function(ResponseComplete value) complete,
    required TResult Function(ResponseReceived value) response,
    required TResult Function(ListeningError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Idle value)? $default, {
    TResult Function(ListeningInitializing value)? initializing,
    TResult Function(ListeningInitialized value)? initialized,
    TResult Function(Listening value)? listening,
    TResult Function(Recognized value)? recognized,
    TResult Function(ResponseComplete value)? complete,
    TResult Function(ResponseReceived value)? response,
    TResult Function(ListeningError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ListeningError implements VoiceListenState {
  const factory ListeningError({String? message}) = _$ListeningError;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListeningErrorCopyWith<ListeningError> get copyWith =>
      throw _privateConstructorUsedError;
}
