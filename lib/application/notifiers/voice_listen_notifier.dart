import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/voice_listen_state.dart';
import 'package:sofia/utils/dialogflow.dart';
import 'package:sofia/widgets/dashboard_widgets/voice_widgets/voice_timer.dart';

class VoiceListenNotifier extends StateNotifier<VoiceListenState> {
  VoiceListenNotifier() : super(VoiceListenState());

  Future<void> speechInitialization() async {
    state = VoiceListenState.initializing();
    try {
      bool isInitialized = await Dialogflow.initializeSpeech();

      if (isInitialized) {
        Dialogflow.isSpeechAvailable = true;
        state = VoiceListenState.initialized();
      } else {
        state = VoiceListenState.error(message: 'Failed to initialize speech!');
      }
    } catch (e) {
      state = VoiceListenState.error(message: 'Faced some issue initializing');
    }
  }

  startListening() async {
    bool isSpeechAvailable = Dialogflow.isSpeechAvailable;

    if (isSpeechAvailable) {
      await Dialogflow.speech.cancel();
      await Dialogflow.speech.stop();

      if (VoiceTimer.voiceTimer != null) {
        VoiceTimer.voiceTimer.cancel();
      }

      state = VoiceListenState.listening();
      await Dialogflow.speech.listen(
        listenFor: Duration(minutes: 1),
        pauseFor: Duration(seconds: 5),
        onResult: (result) async {
          double confidence = result.confidence;

          if (confidence > 0.5) {
            String recognizedVoiceInputString = result.recognizedWords;

            print('Words recog: $recognizedVoiceInputString');

            state = VoiceListenState.recognized(
              recognizedWords: recognizedVoiceInputString,
            );

            VoiceTimer.startTimer(
              (isDone) {
                if (isDone) {
                  state = VoiceListenState.complete();
                }
              },
            );

            // await Future.delayed(Duration(seconds: 5)).whenComplete(
            //   () => state = VoiceListenState.complete(),
            // );
          }
        },
      );
    } else {
      state = VoiceListenState.error(message: 'Speech not initialized');
    }
  }
}
