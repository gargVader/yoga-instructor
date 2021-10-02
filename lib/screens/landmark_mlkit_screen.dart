import 'dart:convert';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sofia/model/landmarks.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/string.dart';
// import 'package:sofia/screens/recognizer_oak_screen.dart';
// import 'package:sofia/screens/timer_overlay.dart';
import 'package:sofia/screens/timer_screen.dart';
import 'package:sofia/utils/dialogflow.dart';
// import 'package:sofia/utils/ssh_connectivity.dart';
import 'package:sofia/utils/video_manager.dart';
import 'package:sofia/widgets/landmark_oak_widgets/landmark_painter.dart';
import 'package:sofia/widgets/recognizer_mlkit_screen/painter/pose_painter_mlkit.dart';
// import 'package:ssh2/ssh2.dart';
// import 'package:ssh/ssh.dart';
import 'package:wakelock/wakelock.dart';

import '../main.dart';

// import '../secrets.dart';

class LandmarkMLKitScreen extends StatefulWidget {
  final Pose? pose;
  final String? trackName;
  final NativeDeviceOrientation screenRotation;

  const LandmarkMLKitScreen({
    Key? key,
    required this.pose,
    required this.trackName,
    required this.screenRotation,
  }) : super(key: key);

  @override
  _LandmarkMLKitScreenState createState() => _LandmarkMLKitScreenState();
}

class _LandmarkMLKitScreenState extends State<LandmarkMLKitScreen>
    with WidgetsBindingObserver {
  int _insideFrameCount = 0;

  CameraController? _controller;
  CustomPaint? customPaint;
  int _cameraIndex = 1;
  int pointsWithinFrameCount = 0;
  int _quarterTurns = 0;
  late final InputImageRotation _imageRotation;

  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  bool _isCameraAllowed = true;

  String _status = 'Initializing camera...';
  Color _statusColor = Colors.red;
  // List<Landmark>? _landmarks;
  String? _trackName;

  final configBox = Hive.box('config');

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
      _status =
          'You are not within the frame of the camera. Please stay in frame while it starts.';
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await poseDetector.close();
    // await _controller?.stopImageStream();
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

    // final camera = cameras[_cameraIndex];

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

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(
      inputImage: inputImage,
      useClassifier: false,
    );
    // poses.forEach((pose) {
    //   print('FF_POSE: ${pose.name}, FF_ACCURACY: ${pose.accuracy}');
    //   if (_isDetectionAllowed == true) {
    //     setOakRecognitions(pose.name, pose.accuracy);
    //   }
    // });

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      // _insideFrameCount = 0;
      // _status =
      //     'You are not within the frame of the camera. Please stay in frame while it starts.';
      // _statusColor = Colors.red;

      final painter = PosePainterMLKit(
        poses: poses,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
        onDraw: (value) async {
          pointsWithinFrameCount = value;
          // print('POINTS: $value');

          if (pointsWithinFrameCount > 22) {
            _insideFrameCount++;
            _status =
                "You're within the camera frame. Please stay here until it starts";
            _statusColor = Colors.green;
          } else {
            _insideFrameCount = 0;
            _status =
                'You are not within the frame of the camera. Please stay in frame while it starts.';
            _statusColor = Colors.red;
          }

          if (_insideFrameCount > 50) {
            _stopLiveFeed();

            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, _, __) => TimerScreen(
                    pose: widget.pose,
                    track: _trackName,
                    screenRotation: widget.screenRotation,
                  ),
                ),
                result: 'navigated',
              );
            });
          }
        },
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

  @override
  void initState() {
    // _videoController = _videoController..play();

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    WidgetsBinding.instance?.addObserver(this);
    Wakelock.enable();
    _trackName = widget.trackName;

    VideoManager.initializeVideoController(videoUrl: widget.pose!.videoUrl);

    Dialogflow.bodyVisible();

    // testNavigationToRecognizerMLKit();

    // To start the camera feed along with the landmark painter
    _startLiveFeed();

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
      poseDetector.close();

      _isCameraAllowed = false;
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    final camera = cameras[_cameraIndex];

    ///
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _status =
          'You are not within the frame of the camera. Please stay in frame while it starts.';
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });

    ///

    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );

    _controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        print('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        _status =
            'You are not within the frame of the camera. Please stay in frame while it starts.';
        _controller?.startImageStream(_processCameraImage);
      });
    } on CameraException catch (e) {
      print('CAMERA EXCEPTION: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------
    // FOR TESTING ONLY - REMOVE THIS <<
    // ----------------------------------------------------------
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   // DeviceOrientation.landscapeLeft,
    // ]);

    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    // ----------------------------------------------------------
    // >> FOR TESTING ONLY - REMOVE THIS
    // ----------------------------------------------------------

    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    // print('SCREEN: w: $width x h: $height');

    double frac = height / camHeight;

    double containerWidth = camWidth * frac;
    double containerHeight = height;

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        _stopLiveFeed();
        // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            mounted
                ? _controller != null
                    ? _controller!.value.isInitialized && _isCameraAllowed
                        ? Center(
                            child: SizedBox(
                              height: height,
                              child: RotatedBox(
                                quarterTurns: _quarterTurns,
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
            mounted && _controller != null && customPaint != null
                ? _controller!.value.isInitialized
                    ? Center(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _statusColor,
                                  width: 4.0,
                                ),
                              ),
                              // color: Colors.black,
                              // color: Colors.black38,
                              child: customPaint!,
                              height: height,
                              width: height *
                                  _controller!.value.previewSize!.aspectRatio,
                              // height: screenSize.height * 0.4,
                              // width: screenSize.height *
                              //     0.4 *
                              //     _controller!.value.aspectRatio,
                            ),
                          ),
                        ),
                      )
                    : Container()
                : Container(),
            mounted && _controller != null
                ? _controller!.value.isInitialized
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _statusColor,
                              width: 4.0,
                            ),
                          ),
                          child: RotatedBox(
                            quarterTurns: _quarterTurns,
                            child: AspectRatio(
                              aspectRatio: 1 / _controller!.value.aspectRatio,
                              child: Container(),
                            ),
                          ),
                        ),
                      )
                    : Container()
                : Container(),
            // Center(
            //   child: CustomPaint(
            //     foregroundPainter: LandmarkPainter(
            //       landmarks: _landmarks,
            //       fraction: frac,
            //       color: _statusColor,
            //     ),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         // border: Border.all(
            //         //   color: Colors.red,
            //         //   width: 5,
            //         // ),
            //       ),
            //       height: containerHeight,
            //       width: containerWidth,
            //     ),
            //   ),
            // ),
            Container(
              color: _statusColor,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Text(
                  // 'You are not within the frame of the camera. Please stay in frame while it starts.',
                  _status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
