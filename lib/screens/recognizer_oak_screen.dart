import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/res/string.dart';
import 'package:sofia/screens/score_overlay.dart';
import 'package:sofia/utils/dialogflow.dart';
import 'package:sofia/utils/ssh_connectivity.dart';
import 'package:sofia/utils/video_manager.dart';
import 'package:sofia/widgets/recognizer_oak_screen/record_indicator.dart';
import 'package:sofia/widgets/recognizer_screen/scrore_viewer_widget.dart';
import 'package:ssh/ssh.dart';
import 'package:video_player/video_player.dart';

import 'package:sofia/model/pose.dart';

import '../secrets.dart';

class RecognizerOakScreen extends StatefulWidget {
  final Pose pose;
  final String trackName;
  // final CameraController cameraController;

  const RecognizerOakScreen({
    Key key,
    @required this.pose,
    // @required this.cameraController,
    @required this.trackName,
  }) : super(key: key);

  @override
  _RecognizerOakScreenState createState() => _RecognizerOakScreenState();
}

class _RecognizerOakScreenState extends State<RecognizerOakScreen> {
  SSHConnectivity _sshConnectivity = SSHConnectivity();

  Timer _recognitionTimer;
  int _start = 10;

  SSHClient _client;
  final configBox = Hive.box('config');

  // StreamSubscription _dataStream;
  // final FirebaseDatabase _database = FirebaseDatabase();
  String _currentPoseName;
  String _trackName;
  VideoPlayerController _videoController;
  // CameraController _cameraController;
  List<int> _pausePoints;
  int _currentPauseIndex = 0;
  int _totalFramesPositive = 0;
  double _myPoseAcuracy = 0.0;
  double _myPoseAcuracyTotal = 0.0;

  // bool _isDetecting = false;
  bool _isDetectionAllowed = false;
  bool _isPoseCorrectStatus = false;
  bool _isSSHConnectionEstablished = false;

  Tween<double> _accuracyTween;

  DateTime _startTime;
  int _poseIndex;

  String _status = 'Initializing OAK-D...';
  bool _isOAKAvailable = true;
  String _processId;

  // Future<void> initializeVideoController() async {
  //   _videoController = VideoPlayerController.network(
  //       'https://stream.mux.com/kiBM5MAziq4wGLnc2GCVixAL8EXYg7wcUDA00VcSkzNM.m3u8.m3u8')
  //     ..initialize().then((_) {
  //       setState(() {});
  //     })
  //     ..play();

  //   setState(() {});
  // }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _recognitionTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            setState(() {
              _isDetectionAllowed = false;
              _start = 10;
              _currentPauseIndex == _pausePoints.length - 1
                  ? _currentPauseIndex = -1
                  : _currentPauseIndex++;
            });

            _videoController.play();

            if (_myPoseAcuracyTotal == 0.0) {
              _myPoseAcuracyTotal = _myPoseAcuracy;
            } else {
              _myPoseAcuracyTotal = (_myPoseAcuracyTotal + _myPoseAcuracy) / 2;
            }
            _totalFramesPositive = 0;

            setState(() {});
          });
        } else {
          _start--;
          print(_start);
        }
      },
    );
  }

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
    } else if (output.contains("RECOGNIZED:")) {
      // print(output.substring(12));
      if (_isDetectionAllowed == true) {
        var rawJSONData =
            output.substring(12).replaceAll("\"", "").replaceAll("\'", "\"");
        print('RAW: $rawJSONData');

        Map<String, dynamic> parsedJSON = jsonDecode(rawJSONData);

        print('PARSED: ${parsedJSON['pose']}');

        String poseName = parsedJSON['pose'];
        double poseAccuracy = parsedJSON['accuracy'];

        setOakRecognitions(poseName, poseAccuracy);
      }
      // setState(() {
      //   _status = output.substring(12).trim();
      // });
    } else if (output.contains("KILL:")) {
      setState(() {
        _status = "Not initizlized";
      });
    }
  }

  // streamListener() {
  //   _dataStream = _database.reference().child('123').onValue.listen((event) {
  //     print('hello');
  //     DataSnapshot oakDataSnapshot = event.snapshot;
  //     String poseName = oakDataSnapshot.value['pose'];
  //     double poseAccuracy = oakDataSnapshot.value['accuracy'];

  //     setOakRecognitions(poseName, poseAccuracy);
  //   });
  // }

  setOakRecognitions(String name, double accuracy) async {
    if (_isDetectionAllowed) {
      String label = name;
      double confidence = accuracy;

      print('RECOG: $label (current: $confidence, total avg: $_myPoseAcuracy)');

      if (_currentPoseName.replaceAll(' ', '_') == label) {
        _totalFramesPositive++;

        if (_totalFramesPositive == 1) {
          _isPoseCorrectStatus = true;
          _myPoseAcuracy = confidence;
          setState(() {});
        } else if (_totalFramesPositive > 1) {
          _myPoseAcuracy = (_myPoseAcuracy + confidence) / 2;
        } else {
          if (_isPoseCorrectStatus) {
            _myPoseAcuracy = (_myPoseAcuracy + confidence) / 2;
            setState(() {});
          }
        }
      } else {
        _totalFramesPositive = 0;

        setState(() {
          _isPoseCorrectStatus = false;
        });
      }

      // if (_currentPoseName == label) {
      //   _totalFramesPositive++;

      //   if (_totalFramesPositive == 20) {
      //     _isPoseCorrectStatus = true;
      //     _myPoseAcuracy = confidence;
      //     setState(() {});
      //   } else if (_totalFramesPositive > 100) {
      //     // await _cameraController?.stopImageStream();
      //     _myPoseAcuracy = (_myPoseAcuracy + confidence) / 2;

      //     setState(() {
      //       _isDetectionAllowed = false;
      //       _currentPauseIndex == _pausePoints.length - 1
      //           ? _currentPauseIndex = -1
      //           : _currentPauseIndex++;
      //     });

      //     _videoController.play();

      //     if (_myPoseAcuracyTotal == 0.0) {
      //       _myPoseAcuracyTotal = _myPoseAcuracy;
      //     } else {
      //       _myPoseAcuracyTotal = (_myPoseAcuracyTotal + _myPoseAcuracy) / 2;
      //     }

      //     _totalFramesPositive = 0;

      //     setState(() {});
      //   } else {
      //     if (_isPoseCorrectStatus) {
      //       _myPoseAcuracy = (_myPoseAcuracy + confidence) / 2;
      //       setState(() {});
      //     }
      //   }
      // } else {
      //   _totalFramesPositive = 0;

      //   setState(() {
      //     _isPoseCorrectStatus = false;
      //   });
      // }
    }
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);

    _client = SSHClient(
      host: configBox.get(hiveHostName) ?? PiConfig.hostname,
      username: configBox.get(hiveUsername) ?? PiConfig.username,
      port: configBox.get(hivePort) ?? PiConfig.port,
      passwordOrKey: configBox.get(hivePassword) ?? PiConfig.password,
    );

    // streamListener();

    // _database.reference().child('123').onValue.listen((event) {
    //   print('hello');
    //   DataSnapshot oakDataSnapshot = event.snapshot;
    //   String poseName = oakDataSnapshot.value['pose'];
    //   double poseAccuracy = oakDataSnapshot.value['accuracy'];

    //   setOakRecognitions(poseName, poseAccuracy);
    // });

    // _cameraController = widget.cameraController;
    _videoController = VideoManager.videoController;

    _pausePoints = widget.pose.pausePoints;
    _currentPoseName = widget.pose.title;
    _trackName = widget.trackName;
    _poseIndex = 1;

    bool _shouldSendIndex = false;

    if (_pausePoints.length > 1) _shouldSendIndex = true;

    _currentPoseName += _shouldSendIndex ? '$_poseIndex' : '';

    // Establishing the SSH connection
    _sshConnectivity.startRecognitionScript(
      client: _client,
      poseName: _currentPoseName,
      trackName: _trackName,
      onReceive: (String output) {
        output = output.trim();
        processSSHOutput(output);
      },
    );

    // _poseIndex = widget.pose.index;
    print('FIREBASE NAME: $_currentPoseName, INDEX: $_poseIndex');

    _accuracyTween = Tween(
      begin: 0.0,
      end: _myPoseAcuracy,
    );

    _videoController.play();

    _startTime = DateTime.now();

    _videoController.addListener(() {
      final bool isPlaying = _videoController.value.isPlaying;

      if (isPlaying) {
        int currentPositionInSeconds =
            _videoController.value.position.inSeconds;

        if (currentPositionInSeconds ==
                (_currentPauseIndex == -1
                    ? 0
                    : _pausePoints[_currentPauseIndex]) &&
            mounted) {
          _videoController.pause();
          setState(() {
            _isDetectionAllowed = true;
          });
          Dialogflow.poseRecognition(onComplete: (isComplete) {
            if (isComplete) {
              setState(() {
                _isDetectionAllowed = false;
                _start = 3;
                _currentPauseIndex == _pausePoints.length - 1
                    ? _currentPauseIndex = -1
                    : _currentPauseIndex++;
              });

              _videoController.play();

              if (_myPoseAcuracyTotal == 0.0) {
                _myPoseAcuracyTotal = _myPoseAcuracy;
              } else {
                _myPoseAcuracyTotal =
                    (_myPoseAcuracyTotal + _myPoseAcuracy) / 2;
              }
              _totalFramesPositive = 0;

              setState(() {});

              // streamListener();
              // startTimer();
              // setState(() {
              //   _isDetectionAllowed = true;
              // });
            }
          });
        }
      }

      if (_videoController.value.duration == _videoController.value.position &&
          !_videoController.value.isPlaying) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, _, __) => ScoreOverlay(
              startTime: _startTime,
              totalAccuracy: _myPoseAcuracyTotal,
              pose: widget.pose,
            ),
          ),
        );
        print('Accuracy each: $_myPoseAcuracy, total: $_myPoseAcuracyTotal');
      }
    });

    ////...

    // _cameraController.startImageStream((image) {
    //   if (!_isDetecting && _isDetectionAllowed) {
    //     _isDetecting = true;

    //     Tflite.runModelOnFrame(
    //       imageMean: 128,
    //       imageStd: 128,
    //       bytesList: image.planes.map((plane) {
    //         return plane.bytes;
    //       }).toList(),
    //       imageHeight: image.height,
    //       imageWidth: image.width,
    //       asynch: true,
    //       rotation: 180,
    //       numResults: 1,
    //       threshold: 0.2,
    //     ).then((recognitions) async {
    //       if (_isDetectionAllowed) {
    //         setRecognitions(recognitions, image.height, image.width);
    //         _isDetecting = false;
    //       }
    //     });
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    // _recognitionTimer.cancel();
    _videoController.dispose();
    // _cameraController.dispose();
    if (_isOAKAvailable)
      _sshConnectivity.stopRecognitionScript(
        client: _client,
        processId: _processId,
      );
    // _dataStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _videoController.value.initialized
                  ? OverflowBox(
                      maxWidth: screenSize.width,
                      maxHeight:
                          screenSize.width * _videoController.value.aspectRatio,
                      child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      ),
                    )
                  : Container(),

              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: _isDetectionAllowed ? 1.0 : 0.4,
                  child: ScroreViewerWidget(
                    accuracyTween: _accuracyTween,
                    accuracy: double.parse(_myPoseAcuracy.toStringAsFixed(2)),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Container(
              //     // height: screenSize.height * 0.7,
              //     width: screenSize.width * 0.215,
              //     color: Colors.white38,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(
              //           height: screenSize.height * 0.3,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Text(
              //             'Score: ${_confidence.toStringAsFixed(2)}',
              //             style: TextStyle(
              //               fontSize: 40.0,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Icon(
              //             Icons.circle,
              //             size: 32,
              //             color: _isPoseCorrectStatus
              //                 ? Colors.greenAccent
              //                 : Colors.redAccent,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Hero(
              //   tag: 'camera_view',
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: ClipRRect(
              //       borderRadius:
              //           BorderRadius.only(bottomLeft: Radius.circular(20)),
              //       child: RotatedBox(
              //         quarterTurns: 1,
              //         child: SizedBox(
              //           // height: screenSize.height / 2,
              //           width: screenSize.width * 0.16,
              //           child: AspectRatio(
              //             aspectRatio: _cameraController.value.aspectRatio,
              //             child: CameraPreview(_cameraController),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Palette.darkShade,
              //     borderRadius: BorderRadius.only(
              //       bottomRight: Radius.circular(10.0),
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //       left: 16.0,
              //       right: 16.0,
              //       top: 10.0,
              //       bottom: 8.0,
              //     ),
              //     child: Text(
              //       'Connecting to OAK-D',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 16.0,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: _isSSHConnectionEstablished
                      ? Colors.transparent
                      : Palette.darkShade,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 10.0,
                    bottom: 8.0,
                  ),
                  child: _isSSHConnectionEstablished
                      ? Row(
                          children: [
                            RecordIndicator(),
                            SizedBox(width: 8.0),
                            Text(
                              'OAK-D',
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          _status,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                ),
              ),
            ],
          ),
          // child: Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Text(
          //         'pose',
          //         style: TextStyle(
          //           fontSize: 24.0,
          //         ),
          //       ),
          //     ),
          //     _videoController.value.initialized
          //         ? Flexible(
          //             child: AspectRatio(
          //               aspectRatio: _videoController.value.aspectRatio,
          //               child: VideoPlayer(_videoController),
          //             ),
          //           )
          //         : Container(),
          //   ],
          // ),
        ),
      ),
    );
  }
}
