import 'dart:async';
// import 'dart:convert';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:sofia/model/landmarks.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/res/string.dart';
import 'package:sofia/screens/score_overlay.dart';
import 'package:sofia/utils/dialogflow.dart';
import 'package:sofia/utils/video_manager.dart';
import 'package:sofia/widgets/landmark_oak_widgets/landmark_painter.dart';
import 'package:sofia/widgets/recognizer_mlkit_screen/painter/pose_painter_mlkit.dart';
import 'package:sofia/widgets/recognizer_oak_screen/record_indicator.dart';
import 'package:sofia/widgets/recognizer_screen/scrore_viewer_widget.dart';

import 'package:video_player/video_player.dart';

import 'package:sofia/model/pose.dart';

import '../main.dart';

// import '../secrets.dart';

class RecognizerMLKitScreen extends StatefulWidget {
  final Pose? pose;
  final String? trackName;
  // final CameraController cameraController;

  const RecognizerMLKitScreen({
    Key? key,
    required this.pose,
    // @required this.cameraController,
    required this.trackName,
  }) : super(key: key);

  @override
  _RecognizerMLKitScreenState createState() => _RecognizerMLKitScreenState();
}

class _RecognizerMLKitScreenState extends State<RecognizerMLKitScreen> {
  CameraController? _controller;
  CustomPaint? customPaint;
  int _cameraIndex = 1;

  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;

  Timer? _recognitionTimer;
  int _start = 10;

  final configBox = Hive.box('config');

  List<Landmark>? _landmarks;
  Color _landmarkColor = Colors.white;

  String? _currentPoseName;
  String _indexedPoseName = '';
  String? _trackName;
  VideoPlayerController? _videoController;

  List<int>? _pausePoints;
  int _currentPauseIndex = 0;
  int _totalFramesPositive = 0;
  double _myPoseAcuracy = 0.0;
  double? _myPoseAcuracyTotal = 0.0;

  // bool _isDetecting = false;
  bool _isDetectionAllowed = false;
  bool _isPoseCorrectStatus = false;
  bool _isSSHConnectionEstablished = false;
  bool _shouldSendIndex = false;

  Tween<double>? _accuracyTween;

  DateTime? _startTime;
  int _poseIndex = 0;
  int vCount = 0;

  String _status = 'Initializing OAK-D...';
  String? _processId;

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    await poseDetector.close();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        // InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
        InputImageRotation.Rotation_180deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    processImage(inputImage);
  }

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
              _currentPauseIndex == _pausePoints!.length - 1
                  ? _currentPauseIndex = -1
                  : _currentPauseIndex++;
            });

            _videoController!.play();

            if (_myPoseAcuracyTotal == 0.0) {
              _myPoseAcuracyTotal = _myPoseAcuracy;
            } else {
              _myPoseAcuracyTotal = (_myPoseAcuracyTotal! + _myPoseAcuracy) / 2;
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

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(
      inputImage: inputImage,
      useClassifier: true,
    );

    poses.forEach((pose) {
      print('FF_POSE: ${pose.name}, FF_ACCURACY: ${pose.accuracy}');
      if (_isDetectionAllowed == true) {
        setOakRecognitions(pose.name, pose.accuracy);
      }
    });

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainterMLKit(
        poses: poses,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
        onDraw: (_) {},
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }

    isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }

  // processSSHOutput(String output) async {
  //   if (output.contains("ERROR(1)")) {
  //     setState(() {
  //       _status = "Couldn't find device";
  //       _isOAKAvailable = false;
  //     });
  //   } else if (output.contains("ERROR(2)")) {
  //     setState(() {
  //       _status = "Failed to connect with device";
  //       _isOAKAvailable = false;
  //     });
  //   } else if (output.contains("PID:")) {
  //     // print(output.substring(5));
  //     setState(() {
  //       _status = "Initialized";
  //       _processId = output.substring(5).trim();
  //     });
  //   } else if (output.contains("INFO:")) {
  //     // print(output.substring(6));
  //     setState(() {
  //       _status = output.substring(6).trim();
  //       if (_status == "Ready") {
  //         _isSSHConnectionEstablished = true;
  //       }
  //     });
  //   } else if (output.contains("LANDMARKS:")) {
  //     // print(output.substring(12));

  //     var rawJSONData = output.substring(11).replaceAll("\'", "\"");
  //     // print('RAW: $rawJSONData');

  //     Map<String, dynamic> parsedJSON = jsonDecode(rawJSONData);

  //     final data = Landmarks.fromJson(parsedJSON);
  //     // print('PARSED: ${data.landmarks[0].x}');

  //     setState(() {
  //       _landmarks = data.landmarks;
  //     });
  //   } else if (output.contains("RECOGNIZED:")) {
  //     // print(output.substring(12));
  //     if (_isDetectionAllowed == true) {
  //       var rawJSONData =
  //           output.substring(12).replaceAll("\"", "").replaceAll("\'", "\"");
  //       // print('RAW: $rawJSONData');

  //       Map<String, dynamic> parsedJSON = jsonDecode(rawJSONData);

  //       // print('PARSED: ${parsedJSON['pose']}');

  //       String? poseName = parsedJSON['pose'];
  //       double? poseAccuracy = parsedJSON['accuracy'];

  //       setOakRecognitions(poseName, poseAccuracy);
  //     }
  //     // setState(() {
  //     //   _status = output.substring(12).trim();
  //     // });
  //   } else if (output.contains("KILL:")) {
  //     setState(() {
  //       _status = "Not initizlized";
  //     });
  //   }
  // }

  // streamListener() {
  //   _dataStream = _database.reference().child('123').onValue.listen((event) {
  //     print('hello');
  //     DataSnapshot oakDataSnapshot = event.snapshot;
  //     String poseName = oakDataSnapshot.value['pose'];
  //     double poseAccuracy = oakDataSnapshot.value['accuracy'];

  //     setOakRecognitions(poseName, poseAccuracy);
  //   });
  // }

  setOakRecognitions(String? name, double? accuracy) async {
    print("helloo");
    if (_isDetectionAllowed) {
      String? label = name;
      double? confidence = accuracy;

      print('RECOG: $label (current: $confidence, total avg: $_myPoseAcuracy)');

      if (_indexedPoseName.replaceAll(' ', '_') == label) {
        _totalFramesPositive++;

        setState(() {
          _landmarkColor = Colors.green;
        });

        if (_totalFramesPositive == 1) {
          _isPoseCorrectStatus = true;
          _myPoseAcuracy = confidence!;
          setState(() {});
        } else if (_totalFramesPositive > 1) {
          _myPoseAcuracy = (_myPoseAcuracy + confidence!) / 2;
        } else {
          if (_isPoseCorrectStatus) {
            _myPoseAcuracy = (_myPoseAcuracy + confidence!) / 2;
            setState(() {});
          }
        }
      } else {
        _totalFramesPositive = 0;

        setState(() {
          _isPoseCorrectStatus = false;
          _landmarkColor = Colors.red;
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
      // DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);

    // _client = SSHClient(
    //   host: configBox.get(hiveHostName) ?? PiConfig.hostname,
    //   username: configBox.get(hiveUsername) ?? PiConfig.username,
    //   port: configBox.get(hivePort) ?? PiConfig.port,
    //   passwordOrKey: configBox.get(hivePassword) ?? PiConfig.password,
    // );

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

    _pausePoints = widget.pose!.pausePoints;
    _currentPoseName = widget.pose!.title;
    _trackName = widget.trackName;
    _poseIndex = 1;

    if (_pausePoints!.length > 1) _shouldSendIndex = true;

    _indexedPoseName = _currentPoseName!;

    if (_shouldSendIndex) {
      _indexedPoseName += '$_poseIndex';
    }

    // _poseIndex = widget.pose.index;
    print('FIREBASE NAME: $_currentPoseName, INDEX: $_poseIndex');

    _accuracyTween = Tween(
      begin: 0.0,
      end: _myPoseAcuracy,
    );

    _startLiveFeed();

    _videoController!.play();

    _startTime = DateTime.now();

    _videoController!.addListener(() async {
      final bool isPlaying = _videoController!.value.isPlaying;

      if (isPlaying) {
        int currentPositionInSeconds =
            _videoController!.value.position.inSeconds;

        if (currentPositionInSeconds ==
                (_currentPauseIndex == -1
                    ? 0
                    : _pausePoints![_currentPauseIndex]) &&
            mounted) {
          _videoController!.pause();
          setState(() {
            _isDetectionAllowed = true;
            _landmarkColor = Colors.red;
            if (_shouldSendIndex) {
              _poseIndex++;
            }
          });
          Dialogflow.poseRecognition(onComplete: (isComplete) {
            if (isComplete) {
              setState(() {
                _isDetectionAllowed = false;
                _start = 3;
                _currentPauseIndex == _pausePoints!.length - 1
                    ? _currentPauseIndex = -1
                    : _currentPauseIndex++;

                _landmarkColor = Colors.white;

                if (_shouldSendIndex) {
                  _indexedPoseName = _currentPoseName! + '$_poseIndex';
                }
                _indexedPoseName = _currentPoseName! + '$_poseIndex';
              });

              _videoController!.play();
              //HERE
              // _sshConnectivity.stopRecognitionScript(
              //   processId: _processId,
              //   client: _client,
              // );

              if (_poseIndex <= _pausePoints!.length && _shouldSendIndex) {
                // Changing the SSH script
                // _sshConnectivity.changeRecognizationScript(
                //   client: _client,
                //   poseName: _indexedPoseName,
                //   trackName: _trackName!,
                //   processId: _processId,
                //   // onReceive: (String output) {
                //   //   output = output.trim();
                //   //   if (this.mounted) processSSHOutput(output);
                //   // },
                // );
              }

              if (_myPoseAcuracyTotal == 0.0) {
                _myPoseAcuracyTotal = _myPoseAcuracy;
              } else {
                _myPoseAcuracyTotal =
                    (_myPoseAcuracyTotal! + _myPoseAcuracy) / 2;
              }
              _totalFramesPositive = 0;

              setState(() {});
            }
          });
        }
      }

      if (_videoController!.value.duration ==
              _videoController!.value.position &&
          !_videoController!.value.isPlaying &&
          vCount == 0) {
        setState(() {
          vCount++;
        });
        _stopLiveFeed();
        await Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, _, __) => ScoreOverlay(
              startTime: _startTime,
              totalAccuracy: _myPoseAcuracyTotal,
              pose: widget.pose,
            ),
          ),
          result: 'navigated',
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
    _videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // print('SCREEN: w: $width x h: $height');
    double height = screenSize.height * 0.35;

    double frac = height / camHeight;

    double containerWidth = camWidth * frac;
    double containerHeight = height;

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        _stopLiveFeed();
        // if (_isOAKAvailable)
        //   _sshConnectivity.stopRecognitionScript(
        //     processId: _processId,
        //     client: _client,
        //   );
        // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _videoController != null && _videoController!.value.isInitialized
                  ? OverflowBox(
                      maxWidth: screenSize.width,
                      maxHeight: screenSize.width *
                          _videoController!.value.aspectRatio,
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
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
              Align(
                alignment: Alignment.topRight,
                child: mounted && _controller != null
                    ? _controller!.value.isInitialized
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: SizedBox(
                                width: screenSize.height * 0.4,
                                child: AspectRatio(
                                  aspectRatio:
                                      1 / _controller!.value.aspectRatio,
                                  child: _controller!.buildPreview(),
                                ),
                              ),
                            ),
                          )
                        : Container()
                    : Container(),

                // child: CameraView(
                //   camWidth: screenSize.width * 0.16,
                //   // customPaint: customPaint,
                //   onImage: (inputImage) {
                //     processImage(inputImage);
                //   },
                // ),
              ),
              mounted && _controller != null
                  ? _controller!.value.isInitialized
                      ? Align(
                          alignment: Alignment.topRight,
                          child: customPaint != null
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                    ),
                                    child: Container(
                                      // color: Colors.black,
                                      child: customPaint!,
                                      height: screenSize.height * 0.4,
                                      width: screenSize.height *
                                          0.4 *
                                          _controller!.value.aspectRatio,
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      : Container()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
