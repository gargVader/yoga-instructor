import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart' as df;
import 'package:flutter/services.dart';

class Dialogflow {
  static Future<void> initialize() async {
    final df.DialogFlowtter dialogFlowtter = await df.DialogFlowtter.fromFile(
      path: 'assets/dialogflow/sofia_auth.json',
      sessionId: '101',
    );

    final df.QueryInput queryInput = df.QueryInput(
      text: df.TextInput(
        text: 'Initialize the app',
        languageCode: 'en',
      ),
    );

    String rawJson =
        await rootBundle.loadString('assets/dialogflow/config.json');

    Map<String, dynamic> data = jsonDecode(rawJson);

    df.DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
      audioConfig: df.OutputAudioConfig(
        synthesizeSpeechConfig: df.SynthesizeSpeechConfig.fromJson(data),
      ),
    );

    String audioBase64 = response.outputAudio;
    Uint8List audioBytes = response.outputAudioBytes;

    AudioPlayer audioPlayer = AudioPlayer();
    int result = await audioPlayer.playBytes(audioBytes);
  }
}
