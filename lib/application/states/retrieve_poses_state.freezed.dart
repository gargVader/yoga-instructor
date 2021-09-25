// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'retrieve_poses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RetrievePosesStateTearOff {
  const _$RetrievePosesStateTearOff();

  InitialPoseData call() {
    return const InitialPoseData();
  }

  RetrievingPoses retrieving() {
    return const RetrievingPoses();
  }

  RetrievedPoses retrieved(List<Pose> poses) {
    return RetrievedPoses(
      poses,
    );
  }

  ErrorRetrievingPoses error({String? message}) {
    return ErrorRetrievingPoses(
      message: message,
    );
  }
}

/// @nodoc
const $RetrievePosesState = _$RetrievePosesStateTearOff();

/// @nodoc
mixin _$RetrievePosesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Pose> poses) retrieved,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Pose> poses)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialPoseData value) $default, {
    required TResult Function(RetrievingPoses value) retrieving,
    required TResult Function(RetrievedPoses value) retrieved,
    required TResult Function(ErrorRetrievingPoses value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialPoseData value)? $default, {
    TResult Function(RetrievingPoses value)? retrieving,
    TResult Function(RetrievedPoses value)? retrieved,
    TResult Function(ErrorRetrievingPoses value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrievePosesStateCopyWith<$Res> {
  factory $RetrievePosesStateCopyWith(
          RetrievePosesState value, $Res Function(RetrievePosesState) then) =
      _$RetrievePosesStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievePosesStateCopyWith<$Res> {
  _$RetrievePosesStateCopyWithImpl(this._value, this._then);

  final RetrievePosesState _value;
  // ignore: unused_field
  final $Res Function(RetrievePosesState) _then;
}

/// @nodoc
abstract class $InitialPoseDataCopyWith<$Res> {
  factory $InitialPoseDataCopyWith(
          InitialPoseData value, $Res Function(InitialPoseData) then) =
      _$InitialPoseDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialPoseDataCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $InitialPoseDataCopyWith<$Res> {
  _$InitialPoseDataCopyWithImpl(
      InitialPoseData _value, $Res Function(InitialPoseData) _then)
      : super(_value, (v) => _then(v as InitialPoseData));

  @override
  InitialPoseData get _value => super._value as InitialPoseData;
}

/// @nodoc

class _$InitialPoseData implements InitialPoseData {
  const _$InitialPoseData();

  @override
  String toString() {
    return 'RetrievePosesState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialPoseData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Pose> poses) retrieved,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Pose> poses)? retrieved,
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
    TResult Function(InitialPoseData value) $default, {
    required TResult Function(RetrievingPoses value) retrieving,
    required TResult Function(RetrievedPoses value) retrieved,
    required TResult Function(ErrorRetrievingPoses value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialPoseData value)? $default, {
    TResult Function(RetrievingPoses value)? retrieving,
    TResult Function(RetrievedPoses value)? retrieved,
    TResult Function(ErrorRetrievingPoses value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialPoseData implements RetrievePosesState {
  const factory InitialPoseData() = _$InitialPoseData;
}

/// @nodoc
abstract class $RetrievingPosesCopyWith<$Res> {
  factory $RetrievingPosesCopyWith(
          RetrievingPoses value, $Res Function(RetrievingPoses) then) =
      _$RetrievingPosesCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievingPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievingPosesCopyWith<$Res> {
  _$RetrievingPosesCopyWithImpl(
      RetrievingPoses _value, $Res Function(RetrievingPoses) _then)
      : super(_value, (v) => _then(v as RetrievingPoses));

  @override
  RetrievingPoses get _value => super._value as RetrievingPoses;
}

/// @nodoc

class _$RetrievingPoses implements RetrievingPoses {
  const _$RetrievingPoses();

  @override
  String toString() {
    return 'RetrievePosesState.retrieving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RetrievingPoses);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Pose> poses) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieving();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Pose> poses)? retrieved,
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
    TResult Function(InitialPoseData value) $default, {
    required TResult Function(RetrievingPoses value) retrieving,
    required TResult Function(RetrievedPoses value) retrieved,
    required TResult Function(ErrorRetrievingPoses value) error,
  }) {
    return retrieving(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialPoseData value)? $default, {
    TResult Function(RetrievingPoses value)? retrieving,
    TResult Function(RetrievedPoses value)? retrieved,
    TResult Function(ErrorRetrievingPoses value)? error,
    required TResult orElse(),
  }) {
    if (retrieving != null) {
      return retrieving(this);
    }
    return orElse();
  }
}

abstract class RetrievingPoses implements RetrievePosesState {
  const factory RetrievingPoses() = _$RetrievingPoses;
}

/// @nodoc
abstract class $RetrievedPosesCopyWith<$Res> {
  factory $RetrievedPosesCopyWith(
          RetrievedPoses value, $Res Function(RetrievedPoses) then) =
      _$RetrievedPosesCopyWithImpl<$Res>;
  $Res call({List<Pose> poses});
}

/// @nodoc
class _$RetrievedPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievedPosesCopyWith<$Res> {
  _$RetrievedPosesCopyWithImpl(
      RetrievedPoses _value, $Res Function(RetrievedPoses) _then)
      : super(_value, (v) => _then(v as RetrievedPoses));

  @override
  RetrievedPoses get _value => super._value as RetrievedPoses;

  @override
  $Res call({
    Object? poses = freezed,
  }) {
    return _then(RetrievedPoses(
      poses == freezed
          ? _value.poses
          : poses // ignore: cast_nullable_to_non_nullable
              as List<Pose>,
    ));
  }
}

/// @nodoc

class _$RetrievedPoses implements RetrievedPoses {
  const _$RetrievedPoses(this.poses);

  @override
  final List<Pose> poses;

  @override
  String toString() {
    return 'RetrievePosesState.retrieved(poses: $poses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedPoses &&
            (identical(other.poses, poses) ||
                const DeepCollectionEquality().equals(other.poses, poses)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(poses);

  @JsonKey(ignore: true)
  @override
  $RetrievedPosesCopyWith<RetrievedPoses> get copyWith =>
      _$RetrievedPosesCopyWithImpl<RetrievedPoses>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Pose> poses) retrieved,
    required TResult Function(String? message) error,
  }) {
    return retrieved(poses);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Pose> poses)? retrieved,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(poses);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialPoseData value) $default, {
    required TResult Function(RetrievingPoses value) retrieving,
    required TResult Function(RetrievedPoses value) retrieved,
    required TResult Function(ErrorRetrievingPoses value) error,
  }) {
    return retrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialPoseData value)? $default, {
    TResult Function(RetrievingPoses value)? retrieving,
    TResult Function(RetrievedPoses value)? retrieved,
    TResult Function(ErrorRetrievingPoses value)? error,
    required TResult orElse(),
  }) {
    if (retrieved != null) {
      return retrieved(this);
    }
    return orElse();
  }
}

abstract class RetrievedPoses implements RetrievePosesState {
  const factory RetrievedPoses(List<Pose> poses) = _$RetrievedPoses;

  List<Pose> get poses => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetrievedPosesCopyWith<RetrievedPoses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorRetrievingPosesCopyWith<$Res> {
  factory $ErrorRetrievingPosesCopyWith(ErrorRetrievingPoses value,
          $Res Function(ErrorRetrievingPoses) then) =
      _$ErrorRetrievingPosesCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$ErrorRetrievingPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $ErrorRetrievingPosesCopyWith<$Res> {
  _$ErrorRetrievingPosesCopyWithImpl(
      ErrorRetrievingPoses _value, $Res Function(ErrorRetrievingPoses) _then)
      : super(_value, (v) => _then(v as ErrorRetrievingPoses));

  @override
  ErrorRetrievingPoses get _value => super._value as ErrorRetrievingPoses;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorRetrievingPoses(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorRetrievingPoses implements ErrorRetrievingPoses {
  const _$ErrorRetrievingPoses({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RetrievePosesState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorRetrievingPoses &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorRetrievingPosesCopyWith<ErrorRetrievingPoses> get copyWith =>
      _$ErrorRetrievingPosesCopyWithImpl<ErrorRetrievingPoses>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() retrieving,
    required TResult Function(List<Pose> poses) retrieved,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? retrieving,
    TResult Function(List<Pose> poses)? retrieved,
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
    TResult Function(InitialPoseData value) $default, {
    required TResult Function(RetrievingPoses value) retrieving,
    required TResult Function(RetrievedPoses value) retrieved,
    required TResult Function(ErrorRetrievingPoses value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialPoseData value)? $default, {
    TResult Function(RetrievingPoses value)? retrieving,
    TResult Function(RetrievedPoses value)? retrieved,
    TResult Function(ErrorRetrievingPoses value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorRetrievingPoses implements RetrievePosesState {
  const factory ErrorRetrievingPoses({String? message}) =
      _$ErrorRetrievingPoses;

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorRetrievingPosesCopyWith<ErrorRetrievingPoses> get copyWith =>
      throw _privateConstructorUsedError;
}
