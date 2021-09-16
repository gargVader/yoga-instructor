import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'coordinates_translator_mlkit.dart';

class PosePainterMLKit extends CustomPainter {
  PosePainterMLKit({
    required this.poses,
    required this.absoluteImageSize,
    required this.rotation,
    required this.onDraw,
  });

  final List<DetectedPose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final Function(int valve) onDraw;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // final paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 4.0
    //   ..color = Colors.green;

    // final leftPaint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3.0
    //   ..color = Colors.yellow;

    // final rightPaint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3.0
    //   ..color = Colors.blueAccent;

    final List<bool> shouldDrawPointList = [
      true, // nose               1
      false, // left_eye_inner    2
      true, // left_eye           3
      false, // left_eye_outer    4
      false, // right_eye_inner   5
      true, // right_eye          6
      false, // right_eye_outer   7
      false, // left_ear          8
      false, // right_ear         9
      false, // mouth_left        10
      false, // mouth_right       11
      true, // left_shoulder      12
      true, // right_shoulder     13
      true, // left_elbow         14
      true, // right_elbow        15
      true, // left_wrist         16
      true, // right_wrist        17
      true, // left_pinky_1       18
      true, // right_pinky_1      19
      true, // left_index_1       20
      true, // right_index_1      21
      true, // left_thumb_2       22
      true, // right_thumb_2      23
      true, // left_hip           24
      true, // right_hip          25
      true, // left_knee          26
      true, // right_knee         27
      true, // left_ankle         28
      true, // right_ankle        29
      true, // left_heel          30
      true, // right_heel         31
      true, // left_foot_index    32
      true, // right_foot_index   33
    ];

    List<Set<int>> shouldDrawLineList = [
      {5, 2},
      {5, 8},
      {2, 7},
      {8, 10},
      {7, 9},
      {10, 12},
      {9, 11},
      {11, 12},
      {12, 14},
      {11, 13},
      {14, 16},
      {13, 15},
      {16, 22},
      {15, 21},
      {16, 18},
      {15, 17},
      {18, 20},
      {17, 19},
      {20, 16},
      {19, 15},
      {12, 24},
      {11, 23},
      {23, 24},
      {24, 26},
      {23, 25},
      {26, 28},
      {25, 27},
      {28, 30},
      {27, 29},
      {30, 32},
      {29, 31},
      {28, 32},
      {27, 31},
    ];

    poses.forEach((pose) {
      print('FF_POSE: ${pose.name}, FF_ACCURACY: ${pose.accuracy}');
      int index = 0;
      int pointWithinFrameCount = 0;

      // print('POINT ------------------------------------');
      // print('START');
      // print('POINT ------------------------------------');

      pose.landmarks.forEach((_, landmark) {
        if (shouldDrawPointList[index]) {
          final retrievedPoint = Offset(
            translateX(landmark.x, rotation, size, absoluteImageSize),
            translateY(landmark.y, rotation, size, absoluteImageSize),
          );

          if ((retrievedPoint.dx <= size.height && retrievedPoint.dx >= 0) &&
              (retrievedPoint.dy <= size.width && retrievedPoint.dy >= 0)) {
            pointWithinFrameCount++;
          }

          // print('POINT: $retrievedPoint');

          canvas.drawCircle(
            retrievedPoint,
            4,
            paint,
          );
        }

        index++;
      });
      // print('POINT ------------------------------------');
      // print('END --> ${size.height}, ${size.width}');
      // print('POINT------------------------------------');

      onDraw(pointWithinFrameCount);

      // print('INDEX: $index, WITHIN FRAME: $pointWithinFrameCount');

      void paintLine(
        PoseLandmarkType type1,
        PoseLandmarkType type2,
        Paint paintType,
      ) {
        PoseLandmark joint1 = pose.landmarks[type1]!;
        PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
          Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
              translateY(joint1.y, rotation, size, absoluteImageSize)),
          Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
              translateY(joint2.y, rotation, size, absoluteImageSize)),
          paintType,
        );
      }

      shouldDrawLineList.forEach((points) {
        final startPoint = PoseLandmarkType.values[points.first];
        final endPoint = PoseLandmarkType.values[points.last];

        paintLine(
          startPoint,
          endPoint,
          paint,
        );
      });

      // paintLine(
      //   PoseLandmarkType.rightEyeInner,
      //   PoseLandmarkType.leftEyeInner,
      //   paint,
      // );

      // // 5,8
      // paintLine(
      //   PoseLandmarkType.rightEyeInner,
      //   PoseLandmarkType.leftEar,
      //   paint,
      // );

      // // 2,7
      // paintLine(
      //   PoseLandmarkType.leftEyeInner,
      //   PoseLandmarkType.rightEyeOuter,
      //   paint,
      // );

      // // 8,10
      // paintLine(
      //   PoseLandmarkType.leftEar,
      //   PoseLandmarkType.leftMouth,
      //   paint,
      // );

      // // 7,9
      // paintLine(
      //   PoseLandmarkType.rightEyeOuter,
      //   PoseLandmarkType.rightEar,
      //   paint,
      // );

      // // 10,12
      // paintLine(
      //   PoseLandmarkType.rightEyeOuter,
      //   PoseLandmarkType.rightEar,
      //   paint,
      // );

      // //Draw arms
      // paintLine(
      //   PoseLandmarkType.leftShoulder,
      //   PoseLandmarkType.leftElbow,
      //   paint,
      // );

      // paintLine(
      //   PoseLandmarkType.leftElbow,
      //   PoseLandmarkType.leftWrist,
      //   paint,
      // );

      // paintLine(
      //   PoseLandmarkType.rightShoulder,
      //   PoseLandmarkType.rightElbow,
      //   paint,
      // );

      // paintLine(
      //   PoseLandmarkType.rightElbow,
      //   PoseLandmarkType.rightWrist,
      //   paint,
      // );

      // //Draw Body
      // paintLine(
      //   PoseLandmarkType.leftShoulder,
      //   PoseLandmarkType.leftHip,
      //   paint,
      // );

      // paintLine(
      //   PoseLandmarkType.rightShoulder,
      //   PoseLandmarkType.rightHip,
      //   paint,
      // );

      // //Draw legs
      // paintLine(
      //   PoseLandmarkType.leftHip,
      //   PoseLandmarkType.leftAnkle,
      //   paint,
      // );

      // paintLine(
      //   PoseLandmarkType.rightHip,
      //   PoseLandmarkType.rightAnkle,
      //   paint,
      // );
    });
  }

  @override
  bool shouldRepaint(covariant PosePainterMLKit oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
