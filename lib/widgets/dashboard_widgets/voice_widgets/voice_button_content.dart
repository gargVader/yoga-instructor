import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';

class VoiceButtonContent extends StatelessWidget {
  final String recognizedWords;
  final Color blurColor;

  const VoiceButtonContent({
    Key key,
    this.recognizedWords = '',
    this.blurColor = Palette.darkShade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: recognizedWords != '',
            child: Flexible(
              child: Card(
                elevation: 8.0,
                color: Palette.darkShade,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.darkShade,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      recognizedWords,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.5,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Hero(
            tag: 'sofia_voice',
            child: InkWell(
              onTap: () {
                context.read(voiceListenNotifierProvider).startListening();
              },
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(68.0),
                  border: new Border.all(
                    color: blurColor,
                    width: 4.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: blurColor,
                      blurRadius: 12,
                      offset: Offset(0, 0), // Shadow position
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/sofia_voice_assistant.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
