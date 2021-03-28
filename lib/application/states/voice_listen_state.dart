import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_listen_state.freezed.dart';

@freezed
abstract class VoiceListenState with _$VoiceListenState {
  const factory VoiceListenState() = Idle;
  const factory VoiceListenState.initializing() = ListeningInitializing;
  const factory VoiceListenState.initialized() = ListeningInitialized;
  const factory VoiceListenState.listening() = Listening;
  const factory VoiceListenState.recognized(
      {@required String recognizedWords}) = Recognized;
  const factory VoiceListenState.complete() = ListeningComplete;
  const factory VoiceListenState.error({String message}) = ListeningError;
}
