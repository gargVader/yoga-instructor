import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/widgets/preview_screen/rotate_to_landspace_widget.dart';
import 'package:wakelock/wakelock.dart';

import 'landmark_mlkit_screen.dart';

class OrientationScreen extends StatefulWidget {
  final Pose? currentPose;
  final String? trackName;
  const OrientationScreen({
    Key? key,
    required this.currentPose,
    required this.trackName,
  }) : super(key: key);

  @override
  _OrientationScreenState createState() => _OrientationScreenState();
}

class _OrientationScreenState extends State<OrientationScreen> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(
      builder: (context) {
        final orientation = NativeDeviceOrientationReader.orientation(context);
        print('Received new orientation: $orientation');

        if ([
          NativeDeviceOrientation.landscapeLeft,
          NativeDeviceOrientation.landscapeRight,
        ].contains(orientation)) {
          count++;
          if (count == 1) {
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(
                  // builder: (context) => PreviewOakScreen(
                  //   pose: currentPose,
                  //   trackName: _trackName,
                  // ),
                  // builder: (context) => MLKitTest(),
                  // builder: (context) => LandmarkOakScreen(
                  //   pose: currentPose,
                  //   trackName: _trackName,
                  // ),
                  builder: (context) => LandmarkMLKitScreen(
                    pose: widget.currentPose,
                    trackName: widget.trackName,
                    screenRotation: orientation,
                  ),
                ),
                result: 'navigated',
              )
                  .then((result) {
                String? returnedString = result as String?;

                if (returnedString != 'navigated') {
                  print('Orientation Page -> $returnedString');
                  Wakelock.disable();
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);

                  SystemChrome.setEnabledSystemUIOverlays(
                      SystemUiOverlay.values);
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ));
                } else {
                  print('Orientation Page -> $returnedString');
                }
              });
            });
          }
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: [
            NativeDeviceOrientation.landscapeLeft,
            NativeDeviceOrientation.landscapeRight
          ].contains(orientation)
              ? Container()
              : RotateToLandscapeWidget(),
        );
      },
      useSensor: false,
    );
  }
}
