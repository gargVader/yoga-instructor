import 'package:flutter/material.dart';
import 'package:sofia/model/landmarks.dart';

class LandmarkPainter extends CustomPainter {
  final List<Landmark>? landmarks;
  final double fraction;
  final Color color;

  LandmarkPainter({
    required this.landmarks,
    required this.fraction,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
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

    var paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    if (landmarks != null && landmarks!.isNotEmpty) {
      landmarks!.asMap().forEach((index, landmark) {
        if (shouldDrawPointList[index]) {
          Offset point = Offset(landmark.x! * fraction, landmark.y! * fraction);
          canvas.drawCircle(point, 4, paint);
        }
      });

      shouldDrawLineList.forEach((points) {
        Landmark firstLandmark = landmarks![points.first];
        Landmark secondLandmark = landmarks![points.last];

        Offset firstPoint = Offset(
          firstLandmark.x! * fraction,
          firstLandmark.y! * fraction,
        );
        Offset secondPoint = Offset(
          secondLandmark.x! * fraction,
          secondLandmark.y! * fraction,
        );

        canvas.drawLine(firstPoint, secondPoint, paint);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
