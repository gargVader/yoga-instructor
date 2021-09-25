import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sofia/application/states/auth_current_user_state.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/dashboard_screen.dart';
import 'package:sofia/utils/database.dart';
import 'onboarding_screens/login_screen.dart';
import 'onboarding_screens/name_screen.dart';
import 'onboarding_screens/splash_screen.dart';

/// {@template sofia.onboarding}
///
/// This is basically the starting point of the app,
/// loads up the [MaterialApp] here.
///
/// Contains the `dispose()` method for closing any Hive boxes.
///
/// The default orientation of the device is set to only:
/// [portraitUp] & [portraitDown]
///
/// State calls:
/// - `speechInitialization()`
/// - `retrieveTracks()`
/// - `retrievePoses()`
/// - `retrieveUser()`
///
/// {@endtemplate}
///
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      // Redirect to the respective page as per the authentication info
      // Currently using DashboardPage instead of HomePage, to test
      // the new UI
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.white,
        accentColor: Colors.white,
      ),
      home: ProviderListener(
        provider: authCurrentUserNotifierProvider,
        onChange: (context, state) {
          if (state is SignedInUser) {
            context
                .read(voiceListenNotifierProvider.notifier)
                .speechInitialization();

            context
                .read(retrieveTracksNotifierProvider.notifier)
                .retrieveTracks();

            context
                .read(retrievePosesNotifierProvider!('beginners').notifier)
                .retrievePoses();

            context.read(retrieveUserNotifierProvider.notifier).retrieveUser();

            context
                .read(retrieveAttemptsNotifierProvider.notifier)
                .retrieveAttempts();
          }
        },
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch(
              authCurrentUserNotifierProvider,
            );

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: state.when(
                  () {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      context
                          .read(authCurrentUserNotifierProvider.notifier)
                          .getCurrentUser();
                    });
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Palette.loginBackground,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                    return SplashScreen();
                  },
                  finding: () {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Palette.loginBackground,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                    return SplashScreen();
                  },
                  notSignedIn: () => LoginScreen(),
                  alreadySignedIn: (userData) {
                    Database.user = userData;

                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ));

                    return DashboardScreen();
                  },
                  detailsNotUploaded: (user) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Palette.nameBackground,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                    return NameScreen(user: user);
                  },
                  error: (message) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Palette.loginBackground,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                    return LoginScreen();
                  }),
            );
          },
        ),
      ),
      // home: VoiceAssistantScreen(),
    );
  }
}
