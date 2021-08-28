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
      true, // nose
      false, // left_eye_inner
      true, // left_eye
      false, // left_eye_outer
      false, // right_eye_inner
      true, // right_eye
      false, // right_eye_outer
      false, // left_ear
      false, // right_ear
      false, // mouth_left
      false, // mouth_right
      true, // left_shoulder
      true, // right_shoulder
      true, // left_elbow
      true, // right_elbow
      true, // left_wrist
      true, // right_wrist
      true, // left_pinky_1
      true, // right_pinky_1
      true, // left_index_1
      true, // right_index_1
      true, // left_thumb_2
      true, // right_thumb_2
      true, // left_hip
      true, // right_hip
      true, // left_knee
      true, // right_knee
      true, // left_ankle
      true, // right_ankle
      true, // left_heel
      true, // right_heel
      true, // left_foot_index
      true, // right_foot_index
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
