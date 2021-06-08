import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sofia/screens/score_overlay.dart';
import 'package:sofia/utils/dialogflow.dart';
import 'package:sofia/utils/video_manager.dart';
import 'package:sofia/widgets/recognizer_screen/scrore_viewer_widget.dart';
import 'package:video_player/video_player.dart';

import 'package:sofia/model/pose.dart';

class RecognizerOakScreen extends StatefulWidget {
  final Pose pose;
  final CameraController cameraController;

  const RecognizerOakScreen({
    Key key,
    @required this.pose,
    @required this.cameraController,
  }) : super(key: key);

  @override
  _RecognizerOakScreenState createState() => _RecognizerOakScreenState();
}

class _RecognizerOakScreenState extends State<RecognizerOakScreen> {
  Timer _recognitionTimer;
  int _start = 5;

  StreamSubscription _dataStream;
  final FirebaseDatabase _database = FirebaseDatabase();
  String _currentPoseName;
  VideoPlayerController _videoController;
  CameraController _cameraController;
  List<int> _pausePoints;
  int _currentPauseIndex = 0;
  int _totalFramesPositive = 0;
  double _myPoseAcuracy = 0.0;
  double _myPoseAcuracyTotal = 0.0;

  // bool _isDetecting = false;
  bool _isDetectionAllowed = false;
  bool _isPoseCorrectStatus = false;

  Tween<double> _accuracyTween;

  DateTime _startTime;
  List<int> _poseIndex;

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

  streamListener() {
    _dataStream = _database.reference().child('123').onValue.listen((event) {
      print('hello');
      DataSnapshot oakDataSnapshot = event.snapshot;
      String poseName = oakDataSnapshot.value['pose'];
      double poseAccuracy = oakDataSnapshot.value['accuracy'];

      setOakRecognitions(poseName, poseAccuracy);
    });
  }

  setOakRecognitions(String name, double accuracy) async {
    if (_isDetectionAllowed) {
      String label = name;
      double confidence = accuracy;

      print('RECOG: $label (current: $confidence, total avg: $_myPoseAcuracy)');

      if (_currentPoseName == label) {
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

    // streamListener();

    // _database.reference().child('123').onValue.listen((event) {
    //   print('hello');
    //   DataSnapshot oakDataSnapshot = event.snapshot;
    //   String poseName = oakDataSnapshot.value['pose'];
    //   double poseAccuracy = oakDataSnapshot.value['accuracy'];

    //   setOakRecognitions(poseName, poseAccuracy);
    // });

    _cameraController = widget.cameraController;
    _videoController = VideoManager.videoController;

    _pausePoints = widget.pose.pausePoints;
    _currentPoseName = widget.pose.title;

    _poseIndex = widget.pose.index;
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
          Dialogflow.poseRecognition(onComplete: (isComplete) {
            if (isComplete) {
              streamListener();
              startTimer();
              setState(() {
                _isDetectionAllowed = true;
              });
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
    _recognitionTimer.cancel();
    _videoController.dispose();
    _dataStream.cancel();
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
              Hero(
                tag: 'camera_view',
                child: Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(20)),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SizedBox(
                        width: screenSize.width * 0.16,
                        child: AspectRatio(
                          aspectRatio: _cameraController.value.aspectRatio,
                          child: CameraPreview(_cameraController),
                        ),
                      ),
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
