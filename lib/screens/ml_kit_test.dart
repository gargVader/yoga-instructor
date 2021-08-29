import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'camera_view.dart';

class MLKitTest extends StatefulWidget {
  @override
  _MLKitTestState createState() => _MLKitTestState();
}

class _MLKitTestState extends State<MLKitTest> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(inputImage);

    poses.forEach((pose) {
      print('FF_POSE: ${pose.pose}, FF_ACCURACY: ${pose.accuracy}');
    });

    // print('Found ${poses.length} poses');

    // if (inputImage.inputImageData?.size != null &&
    //     inputImage.inputImageData?.imageRotation != null) {
    //   final painter = PosePainter(poses, inputImage.inputImageData!.size,
    //       inputImage.inputImageData!.imageRotation);
    //   customPaint = CustomPaint(painter: painter);
    // } else {
    //   customPaint = null;
    // }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraView(
        title: 'Pose Detector',
        // customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        },
      ),
    );
  }
}
