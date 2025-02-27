import 'dart:async';
// import 'dart:convert';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
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
  final NativeDeviceOrientation screenRotation;

  const RecognizerMLKitScreen({
    Key? key,
    required this.pose,
    required this.trackName,
    required this.screenRotation,
  }) : super(key: key);

  @override
  _RecognizerMLKitScreenState createState() => _RecognizerMLKitScreenState();
}

class _RecognizerMLKitScreenState extends State<RecognizerMLKitScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  CustomPaint? customPaint;

  // Using the front camera by default
  int _cameraIndex = 1;
  int _quarterTurns = 0;
  late final InputImageRotation _imageRotation;

  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  bool _isCameraAllowed = true;

  // Timer? _recognitionTimer;
  // int _start = 10;

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

  bool _isDetectionAllowed = false;
  bool _isPoseCorrectStatus = false;
  bool _shouldSendIndex = false;

  Tween<double>? _accuracyTween;

  DateTime? _startTime;
  int _poseIndex = 0;
  int vCount = 0;

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
      _controller?.lockCaptureOrientation();
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    // await _controller?.stopImageStream();
    await poseDetector.close();
    await _controller?.dispose();
    _isCameraAllowed = false;
    // _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

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
      imageRotation: _imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    processImage(inputImage);
  }

  // void _startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _recognitionTimer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //           setState(() {
  //             _isDetectionAllowed = false;
  //             _start = 10;
  //             _currentPauseIndex == _pausePoints!.length - 1
  //                 ? _currentPauseIndex = -1
  //                 : _currentPauseIndex++;
  //           });

  //           _videoController!.play();

  //           if (_myPoseAcuracyTotal == 0.0) {
  //             _myPoseAcuracyTotal = _myPoseAcuracy;
  //           } else {
  //             _myPoseAcuracyTotal = (_myPoseAcuracyTotal! + _myPoseAcuracy) / 2;
  //           }
  //           _totalFramesPositive = 0;

  //           setState(() {});
  //         });
  //       } else {
  //         _start--;
  //         print(_start);
  //       }
  //     },
  //   );
  // }

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

  setOakRecognitions(String? name, double? accuracy) async {
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
    }
  }

  @override
  void initState() {
    if (widget.screenRotation == NativeDeviceOrientation.landscapeLeft) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
      _quarterTurns = 3;
      _imageRotation = InputImageRotation.Rotation_0deg;
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight, // was default
      ]);
      _quarterTurns = 1;
      _imageRotation = InputImageRotation.Rotation_180deg;
    }

    SystemChrome.setEnabledSystemUIOverlays([]);

    WidgetsBinding.instance?.addObserver(this);

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
            _myPoseAcuracy = 0;
            _landmarkColor = Colors.red;
            if (_shouldSendIndex) {
              _poseIndex++;
            }
          });
          Dialogflow.poseRecognition(onComplete: (isComplete) {
            if (isComplete) {
              setState(() {
                _isDetectionAllowed = false;

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

              if (_myPoseAcuracyTotal == 0.0 &&
                  (_poseIndex == 2 || _poseIndex == 1)) {
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
        print('Accuracy each: $_myPoseAcuracy, total: $_myPoseAcuracyTotal');

        Navigator.of(context).pushReplacement(
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
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _videoController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // print('SCREEN: w: $width x h: $height');
    double height = screenSize.height * 0.35;

    double frac = height / camHeight;

    // double containerWidth = camWidth * frac;
    // double containerHeight = height;

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        _stopLiveFeed();
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
                child: mounted
                    ? _controller != null
                        ? _controller!.value.isInitialized && _isCameraAllowed
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                ),
                                child: RotatedBox(
                                  quarterTurns: _quarterTurns,
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
                        : Container()
                    : Container(),
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
