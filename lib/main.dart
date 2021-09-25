import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sofia/screens/onboarding_screen.dart';
import 'package:sofia/screens/onboarding_screens/oak_d_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// The list of camera types (mainly including: front and back)
List<CameraDescription> cameras = [];
void main() async {
  runZonedGuarded<Future<void>>(() async {
    /// Required because we use calling binding
    /// before run app
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    try {
      // Initialize Hive
      await Hive.initFlutter();
      // Opening the box
      await Hive.openBox('config');
    } catch (e) {
      print('Hive error: $e');
    }

    try {
      // To load the cameras before the app is initialized
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
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Sofia: yoga trainer',
      //   theme: ThemeData(
      //     fontFamily: 'GoogleSans',
      //     primaryColor: Colors.white,
      //     accentColor: Colors.white,
      //   ),
      //   home: LandmarkScreen(),
      // ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
