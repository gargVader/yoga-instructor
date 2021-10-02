import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sofia/model/landmarks.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/string.dart';
import 'package:sofia/screens/recognizer_oak_screen.dart';
import 'package:sofia/screens/timer_overlay.dart';
import 'package:sofia/screens/timer_screen.dart';
import 'package:sofia/utils/dialogflow.dart';
import 'package:sofia/utils/ssh_connectivity.dart';
import 'package:sofia/utils/video_manager.dart';
import 'package:sofia/widgets/landmark_oak_widgets/landmark_painter.dart';
import 'package:ssh2/ssh2.dart';
// import 'package:ssh/ssh.dart';
import 'package:wakelock/wakelock.dart';

import '../secrets.dart';

class LandmarkOakScreen extends StatefulWidget {
  final Pose? pose;
  final String? trackName;

  const LandmarkOakScreen({
    Key? key,
    required this.pose,
    required this.trackName,
  }) : super(key: key);

  @override
  _LandmarkOakScreenState createState() => _LandmarkOakScreenState();
}

class _LandmarkOakScreenState extends State<LandmarkOakScreen> {
  SSHConnectivity _sshConnectivity = SSHConnectivity();
  // String landmarks = '';

  int _insideFrameCount = 0;

  String _status = 'Initializing OAK-D...';
  Color _statusColor = Colors.red;
  bool _isOAKAvailable = true;
  String? _processId;

  bool _isSSHConnectionEstablished = false;
  List<Landmark>? _landmarks;
  final configBox = Hive.box('config');

  String? _trackName;
  late SSHClient _client;

  processSSHOutput(String output) async {
    if (output.contains("ERROR(1)")) {
      setState(() {
        _status = "Couldn't find device";
        _isOAKAvailable = false;
      });
    } else if (output.contains("ERROR(2)")) {
      setState(() {
        _status = "Failed to connect with device";
        _isOAKAvailable = false;
      });
    } else if (output.contains("PID:")) {
      // print(output.substring(5));
      setState(() {
        _status = "Initialized";
        _processId = output.substring(5).trim();
      });
    } else if (output.contains("INFO:")) {
      // print(output.substring(6));
      setState(() {
        _status = output.substring(6).trim();
        if (_status == "Ready") {
          _isSSHConnectionEstablished = true;
        }
      });
    } else if (output.contains("LANDMARKS:")) {
      // print(output.substring(12));

      var rawJSONData = output.substring(11).replaceAll("\'", "\"");
      // print('RAW: $rawJSONData');

      Map<String, dynamic> parsedJSON = jsonDecode(rawJSONData);

      final data = Landmarks.fromJson(parsedJSON);
      // print('PARSED: ${data.landmarks[0].x}');

      if (data.landmarks!.isNotEmpty) {
        _insideFrameCount++;
        _status =
            "You're within the OAK-D camera frame. Please stay here until it starts";
        _statusColor = Colors.green;
      } else {
        _insideFrameCount = 0;
        _status =
            'You are not within the frame of the OAK-D camera. Please stay in frame while it starts.';

        _statusColor = Colors.red;
      }

      setState(() {
        _landmarks = data.landmarks;
      });

      if (_insideFrameCount > 100) {
        if (_isOAKAvailable)
          _sshConnectivity.stopRecognitionScript(
            client: _client,
            processId: _processId,
          );

        await Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, _, __) => TimerScreen(
              pose: widget.pose,
              track: _trackName,
              // TODO: pass the proper orientation
              screenRotation: NativeDeviceOrientation.landscapeRight,
            ),
          ),
          result: 'navigated',
        );
        //     .whenComplete(() {
        //   Navigator.of(context)
        //       .pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => RecognizerOakScreen(
        //         pose: widget.pose,
        //         trackName: _trackName,
        //         // cameraController: _cameraController,
        //       ),
        //     ),
        //     // result: 'navigated',
        //   )
        //       .whenComplete(() {
        //     Wakelock.disable();
        //     SystemChrome.setPreferredOrientations([
        //       DeviceOrientation.portraitUp,
        //       DeviceOrientation.portraitDown,
        //     ]);

        //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //       statusBarColor: Colors.transparent,
        //     ));
        //   });
        // });
      }

      // print('PARSED: ${parsedJSON['pose']}');

      // String poseName = parsedJSON['pose'];
      // double poseAccuracy = parsedJSON['accuracy'];

      // setOakRecognitions(poseName, poseAccuracy);

      // setState(() {
      //   _status = output.substring(12).trim();
      // });
    } else if (output.contains("KILL:")) {
      setState(() {
        _status = "Not initizlized";
      });
    }
  }

  @override
  void initState() {
    // _videoController = _videoController..play();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _client = SSHClient(
      host: configBox.get(hiveHostName) ?? PiConfig.hostname,
      username: configBox.get(hiveUsername) ?? PiConfig.username,
      port: configBox.get(hivePort) ?? PiConfig.port,
      passwordOrKey: configBox.get(hivePassword) ?? PiConfig.password,
    );

    Wakelock.enable();
    _trackName = widget.trackName;

    VideoManager.initializeVideoController(videoUrl: widget.pose!.videoUrl);

    Dialogflow.bodyVisible();

    // Establishing the SSH connection
    _sshConnectivity.startLandmarkScript(
      client: _client,
      onReceive: (String output) {
        output = output.trim();
        if (this.mounted) processSSHOutput(output);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // print('SCREEN: w: $width x h: $height');

    double frac = height / camHeight;

    double containerWidth = camWidth * frac;
    double containerHeight = height;

    return WillPopScope(
      onWillPop: () async {
        if (_isOAKAvailable)
          _sshConnectivity.stopRecognitionScript(
            processId: _processId,
            client: _client,
          );
        return true;
      },
      child: Scaffold(
        backgroundColor: _statusColor,
        body: Stack(
          children: [
            Center(
              child: CustomPaint(
                foregroundPainter: LandmarkPainter(
                  landmarks: _landmarks,
                  fraction: frac,
                  color: _statusColor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // border: Border.all(
                    //   color: Colors.red,
                    //   width: 5,
                    // ),
                  ),
                  height: containerHeight,
                  width: containerWidth,
                ),
              ),
            ),
            Container(
              color: _statusColor.withOpacity(0.6),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Text(
                  // 'You are not within the frame of the OAK-D camera. Please stay in frame while it starts.',
                  _status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        // ---------------------------------------------------------------------
        // Test buttons for the script
        // ---------------------------------------------------------------------
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(landmarks),
        //       RaisedButton(
        //         onPressed: () {
        //           // Establishing the SSH connection
        //           _sshConnectivity.startLandmarkScript(
        //             onReceive: (String output) {
        //               output = output.trim();
        //               processSSHOutput(output);
        //             },
        //           );
        //         },
        //         child: Text('Start script'),
        //       ),
        //       RaisedButton(
        //         onPressed: () =>
        //             _sshConnectivity.stopRecognitionScript(_processId),
        //         child: Text('Stop script'),
        //       ),
        //     ],
        //   ),
        // ),
        // ---------------------------------------------------------------------
      ),
    );
  }
}
