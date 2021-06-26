import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/screens/onboarding_screen.dart';
import 'package:sofia/screens/onboarding_screens/oak_d_screen.dart';

/// The list of camera types (mainly including: front and back)
List<CameraDescription> cameras = [];
void main() async {
  try {
    // To load the cameras before the app is initialized
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
  }

  // Starting point of the app
  runApp(
    ProviderScope(
      child: OnboardingScreen(),
    ),
    // For re-uploading the data to Firebase:
    // DebugScreen(),
    // Test painter
    // CustomPainterTest(),
    // MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Sofia: yoga trainer',
    //   theme: ThemeData(
    //     fontFamily: 'GoogleSans',
    //     primaryColor: Colors.white,
    //     accentColor: Colors.white,
    //   ),
    //   home: OAKDScreen(),
    // ),
  );
}
