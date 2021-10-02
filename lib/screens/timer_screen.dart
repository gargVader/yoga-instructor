import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/recognizer_oak_screen.dart';
import 'package:wakelock/wakelock.dart';

import 'recognizer_mlkit_screen.dart';

class TimerScreen extends StatefulWidget {
  final Pose? pose;
  final String? track;
  final NativeDeviceOrientation screenRotation;

  const TimerScreen({
    Key? key,
    required this.pose,
    required this.track,
    required this.screenRotation,
  }) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  int _start = 5;
  Pose? _currentPose;

  @override
  void initState() {
    super.initState();
    _currentPose = widget.pose;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (_start == 1) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushReplacement(
          // MaterialPageRoute(
          //   builder: (context) => RecognizerOakScreen(
          //     pose: widget.pose,
          //     trackName: widget.track,
          //   ),
          // ),
          MaterialPageRoute(
            builder: (context) => RecognizerMLKitScreen(
              pose: widget.pose,
              trackName: widget.track,
              screenRotation: widget.screenRotation,
            ),
          ),
        )
            .then((result) {
          String? returnedString = result as String?;

          if (returnedString != 'navigated') {
            Wakelock.disable();
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);

            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ));
          }
        });
      });
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: screenSize.height,
                        width: screenSize.height,
                        child: FlareActor(
                          "assets/rive/loading_1.flr",
                          // alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          animation: "run",
                        ),
                      ),
                      Positioned(
                        top: screenSize.height * 0.35,
                        left: screenSize.height / 2 - 20,
                        child: Text(
                          '$_start',
                          style: TextStyle(
                            fontSize: 100.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Starting',
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          _currentPose!.title![0].toUpperCase() +
                              _currentPose!.title!.substring(1) +
                              ' pose',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Palette.lightDarkShade,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
