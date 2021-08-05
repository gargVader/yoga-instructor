import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/voice_listen_state.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/landmark_oak_screen.dart';
import 'package:sofia/screens/preview_oak_screen.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/widgets/dashboard_widgets/voice_widgets/voice_button_content.dart';
import 'package:sofia/widgets/dashboard_widgets/voice_widgets/voice_button_response.dart';
import 'package:wakelock/wakelock.dart';

class SofiaAssistantButton extends StatelessWidget {
  final Database _database = Database();

  SofiaAssistantButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<VoiceListenState>(
      provider: voiceListenNotifierProvider.state,
      onChange: (context, state) async {
        if (state is ResponseComplete) {
          DetectIntentResponse response = state.response;

          List<Pose> poses = await _database.retrievePoses(
            trackName: 'beginners',
          );

          print('PARAMS: ${response.queryResult.parameters}');

          String intentName = response.queryResult.intent.displayName;

          if (intentName == 'Pose intent') {
            if (response.queryResult.parameters.containsKey('pose')) {
              List<dynamic> responsePoseList =
                  response.queryResult.parameters['pose'];
              if (responsePoseList.length == 1) {
                String resolvedPoseName =
                    response.queryResult.parameters['pose'][0];

                poses.forEach((pose) {
                  if (pose.title == resolvedPoseName) {
                    Navigator.of(context).push(
                      // route: Navigate to TFLite screen
                      // MaterialPageRoute(
                      //   builder: (context) => PreviewScreen(
                      //     pose: pose,
                      //   ),
                      // ),
                      // route: Navigate to OAK screen
                      MaterialPageRoute(
                        // builder: (context) => PreviewOakScreen(
                        //   pose: pose,
                        //   trackName: 'beginners',
                        // ),
                        builder: (context) => LandmarkOakScreen(
                          pose: pose,
                          trackName: 'beginners',
                        ),
                      ),
                    );
                    //     .then((result) {
                    //   String returnedString = result as String;

                    //   if (returnedString != 'navigated') {
                    //     Wakelock.disable();
                    //     SystemChrome.setPreferredOrientations([
                    //       DeviceOrientation.portraitUp,
                    //       DeviceOrientation.portraitDown,
                    //     ]);

                    //     SystemChrome.setEnabledSystemUIOverlays(
                    //         SystemUiOverlay.values);
                    //     SystemChrome.setSystemUIOverlayStyle(
                    //         SystemUiOverlayStyle(
                    //       statusBarColor: Colors.transparent,
                    //       statusBarIconBrightness: Brightness.dark,
                    //     ));
                    //   }
                    // });
                  }
                });
              }
            }
          }
        }
      },
      child: Consumer(
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
              recognizedWords: recognizedWords[0].toUpperCase() +
                  recognizedWords.substring(1),
            ),
            response: (responseString) => VoiceButtonResponse(
              blurColor: Palette.accentDarkPink,
              responseString:
                  responseString[0].toUpperCase() + responseString.substring(1),
            ),
            complete: (_) => VoiceButtonContent(),
            error: (message) => Container(),
          );
        },
      ),
    );
  }
}
