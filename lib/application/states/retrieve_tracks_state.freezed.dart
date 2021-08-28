// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'retrieve_tracks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RetrieveTracksStateTearOff {
  const _$RetrieveTracksStateTearOff();

  InitialTrackData call() {
    return const InitialTrackData();
  }

  RetrievingTracks retrieving() {
    return const RetrievingTracks();
  }

  RetrievedTracks retrieved(List<Track> tracks) {
    return RetrievedTracks(
      tracks,
    );
  }

  ErrorRetrievingTracks error({String? message}) {
    return ErrorRetrievingTracks(
      message: message,
    );
  }
}

/// @nodoc
const $RetrieveTracksState = _$RetrieveTracksStateTearOff();

/// @nodoc
mixin _$RetrieveTracksState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Track> tracks) retrieved,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Track> tracks)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialTrackData value) $default, {
    required TResult Function(RetrievingTracks value) retrieving,
    required TResult Function(RetrievedTracks value) retrieved,
    required TResult Function(ErrorRetrievingTracks value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialTrackData value)? $default, {
    TResult Function(RetrievingTracks value)? retrieving,
    TResult Function(RetrievedTracks value)? retrieved,
    TResult Function(ErrorRetrievingTracks value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrieveTracksStateCopyWith<$Res> {
  factory $RetrieveTracksStateCopyWith(
          RetrieveTracksState value, $Res Function(RetrieveTracksState) then) =
      _$RetrieveTracksStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrieveTracksStateCopyWithImpl<$Res>
    implements $RetrieveTracksStateCopyWith<$Res> {
  _$RetrieveTracksStateCopyWithImpl(this._value, this._then);

  final RetrieveTracksState _value;
  // ignore: unused_field
  final $Res Function(RetrieveTracksState) _then;
}

/// @nodoc
abstract class $InitialTrackDataCopyWith<$Res> {
  factory $InitialTrackDataCopyWith(
          InitialTrackData value, $Res Function(InitialTrackData) then) =
      _$InitialTrackDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialTrackDataCopyWithImpl<$Res>
    extends _$RetrieveTracksStateCopyWithImpl<$Res>
    implements $InitialTrackDataCopyWith<$Res> {
  _$InitialTrackDataCopyWithImpl(
      InitialTrackData _value, $Res Function(InitialTrackData) _then)
      : super(_value, (v) => _then(v as InitialTrackData));

  @override
  InitialTrackData get _value => super._value as InitialTrackData;
}

/// @nodoc

class _$InitialTrackData implements InitialTrackData {
  const _$InitialTrackData();

  @override
  String toString() {
    return 'RetrieveTracksState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialTrackData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Track> tracks) retrieved,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Track> tracks)? retrieved,
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
    TResult Function(InitialTrackData value) $default, {
    required TResult Function(RetrievingTracks value) retrieving,
    required TResult Function(RetrievedTracks value) retrieved,
    required TResult Function(ErrorRetrievingTracks value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialTrackData value)? $default, {
    TResult Function(RetrievingTracks value)? retrieving,
    TResult Function(RetrievedTracks value)? retrieved,
    TResult Function(ErrorRetrievingTracks value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialTrackData implements RetrieveTracksState {
  const factory InitialTrackData() = _$InitialTrackData;
}

/// @nodoc
abstract class $RetrievingTracksCopyWith<$Res> {
  factory $RetrievingTracksCopyWith(
          RetrievingTracks value, $Res Function(RetrievingTracks) then) =
      _$RetrievingTracksCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievingTracksCopyWithImpl<$Res>
    extends _$RetrieveTracksStateCopyWithImpl<$Res>
    implements $RetrievingTracksCopyWith<$Res> {
  _$RetrievingTracksCopyWithImpl(
      RetrievingTracks _value, $Res Function(RetrievingTracks) _then)
      : super(_value, (v) => _then(v as RetrievingTracks));

  @override
  RetrievingTracks get _value => super._value as RetrievingTracks;
}

/// @nodoc

class _$RetrievingTracks implements RetrievingTracks {
  const _$RetrievingTracks();

  @override
  String toString() {
    return 'RetrieveTracksState.retrieving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RetrievingTracks);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Track> tracks) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieving();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Track> tracks)? retrieved,
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
    TResult Function(InitialTrackData value) $default, {
    required TResult Function(RetrievingTracks value) retrieving,
    required TResult Function(RetrievedTracks value) retrieved,
    required TResult Function(ErrorRetrievingTracks value) error,
  }) {
    return retrieving(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialTrackData value)? $default, {
    TResult Function(RetrievingTracks value)? retrieving,
    TResult Function(RetrievedTracks value)? retrieved,
    TResult Function(ErrorRetrievingTracks value)? error,
    required TResult orElse(),
  }) {
    if (retrieving != null) {
      return retrieving(this);
    }
    return orElse();
  }
}

abstract class RetrievingTracks implements RetrieveTracksState {
  const factory RetrievingTracks() = _$RetrievingTracks;
}

/// @nodoc
abstract class $RetrievedTracksCopyWith<$Res> {
  factory $RetrievedTracksCopyWith(
          RetrievedTracks value, $Res Function(RetrievedTracks) then) =
      _$RetrievedTracksCopyWithImpl<$Res>;
  $Res call({List<Track> tracks});
}

/// @nodoc
class _$RetrievedTracksCopyWithImpl<$Res>
    extends _$RetrieveTracksStateCopyWithImpl<$Res>
    implements $RetrievedTracksCopyWith<$Res> {
  _$RetrievedTracksCopyWithImpl(
      RetrievedTracks _value, $Res Function(RetrievedTracks) _then)
      : super(_value, (v) => _then(v as RetrievedTracks));

  @override
  RetrievedTracks get _value => super._value as RetrievedTracks;

  @override
  $Res call({
    Object? tracks = freezed,
  }) {
    return _then(RetrievedTracks(
      tracks == freezed
          ? _value.tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<Track>,
    ));
  }
}

/// @nodoc

class _$RetrievedTracks implements RetrievedTracks {
  const _$RetrievedTracks(this.tracks);

  @override
  final List<Track> tracks;

  @override
  String toString() {
    return 'RetrieveTracksState.retrieved(tracks: $tracks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedTracks &&
            (identical(other.tracks, tracks) ||
                const DeepCollectionEquality().equals(other.tracks, tracks)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tracks);

  @JsonKey(ignore: true)
  @override
  $RetrievedTracksCopyWith<RetrievedTracks> get copyWith =>
      _$RetrievedTracksCopyWithImpl<RetrievedTracks>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Track> tracks) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieved(tracks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Track> tracks)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(tracks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialTrackData value) $default, {
    required TResult Function(RetrievingTracks value) retrieving,
    required TResult Function(RetrievedTracks value) retrieved,
    required TResult Function(ErrorRetrievingTracks value) error,
  }) {
    return retrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialTrackData value)? $default, {
    TResult Function(RetrievingTracks value)? retrieving,
    TResult Function(RetrievedTracks value)? retrieved,
    TResult Function(ErrorRetrievingTracks value)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(this);
    }
    return orElse();
  }
}

abstract class RetrievedTracks implements RetrieveTracksState {
  const factory RetrievedTracks(List<Track> tracks) = _$RetrievedTracks;

  List<Track> get tracks => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetrievedTracksCopyWith<RetrievedTracks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorRetrievingTracksCopyWith<$Res> {
  factory $ErrorRetrievingTracksCopyWith(ErrorRetrievingTracks value,
          $Res Function(ErrorRetrievingTracks) then) =
      _$ErrorRetrievingTracksCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$ErrorRetrievingTracksCopyWithImpl<$Res>
    extends _$RetrieveTracksStateCopyWithImpl<$Res>
    implements $ErrorRetrievingTracksCopyWith<$Res> {
  _$ErrorRetrievingTracksCopyWithImpl(
      ErrorRetrievingTracks _value, $Res Function(ErrorRetrievingTracks) _then)
      : super(_value, (v) => _then(v as ErrorRetrievingTracks));

  @override
  ErrorRetrievingTracks get _value => super._value as ErrorRetrievingTracks;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorRetrievingTracks(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorRetrievingTracks implements ErrorRetrievingTracks {
  const _$ErrorRetrievingTracks({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RetrieveTracksState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorRetrievingTracks &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorRetrievingTracksCopyWith<ErrorRetrievingTracks> get copyWith =>
      _$ErrorRetrievingTracksCopyWithImpl<ErrorRetrievingTracks>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Track> tracks) retrieved,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Track> tracks)? retrieved,
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
    TResult Function(InitialTrackData value) $default, {
    required TResult Function(RetrievingTracks value) retrieving,
    required TResult Function(RetrievedTracks value) retrieved,
    required TResult Function(ErrorRetrievingTracks value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialTrackData value)? $default, {
    TResult Function(RetrievingTracks value)? retrieving,
    TResult Function(RetrievedTracks value)? retrieved,
    TResult Function(ErrorRetrievingTracks value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorRetrievingTracks implements RetrieveTracksState {
  const factory ErrorRetrievingTracks({String? message}) =
      _$ErrorRetrievingTracks;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorRetrievingTracksCopyWith<ErrorRetrievingTracks> get copyWith =>
      throw _privateConstructorUsedError;
}
