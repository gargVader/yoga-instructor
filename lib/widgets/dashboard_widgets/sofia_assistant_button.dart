import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/widgets/dashboard_widgets/voice_widgets/voice_button_content.dart';

class SofiaAssistantButton extends StatelessWidget {
  const SofiaAssistantButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final state = watch(voiceListenNotifierProvider.state);

        return state.when(
          () => Container(),
          initializing: () => Container(),
          initialized: () => VoiceButtonContent(),
          listening: () => VoiceButtonContent(
            blurColor: Colors.yellowAccent,
          ),
          recognized: (recognizedWords) => VoiceButtonContent(
            blurColor: Colors.greenAccent[400],
            recognizedWords:
                recognizedWords[0].toUpperCase() + recognizedWords.substring(1),
          ),
          complete: () => VoiceButtonContent(),
          error: (message) => Container(),
        );
      },
    );
  }
}
