import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'package:sofia/model/pose.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/res/string.dart';
import 'package:sofia/screens/landmark_mlkit_screen.dart';
import 'package:sofia/screens/landmark_oak_screen.dart';
import 'package:sofia/screens/orientation_screen.dart';
import 'package:sofia/screens/preview_oak_screen.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:sofia/widgets/common/custom_widgets.dart';
import 'package:sofia/widgets/each_pose_widgets/next_widget.dart';
import 'package:sofia/widgets/each_pose_widgets/prev_next_widget.dart';
import 'package:sofia/widgets/each_pose_widgets/prev_widget.dart';
import 'package:wakelock/wakelock.dart';
import 'package:permission_handler/permission_handler.dart';

class EachPosePage extends StatefulWidget {
  final List<Pose>? poses;
  final String? trackName;
  final int currentIndex;

  const EachPosePage({
    Key? key,
    required this.poses,
    required this.currentIndex,
    required this.trackName,
  }) : super(key: key);

  @override
  _EachPosePageState createState() => _EachPosePageState();
}

class _EachPosePageState extends State<EachPosePage> {
  int? currentIndex;
  Pose? currentPose;
  String? poseName;
  late String poseSubtitle;
  late String poseNameDisplay;
  String? poseImageUrl;
  late List<String> benefitList;

  List<Pose>? poses;
  String? _trackName;
  String? videoUrl;

  @override
  void initState() {
    super.initState();
    poses = widget.poses;
    _trackName = widget.trackName;
    currentIndex = widget.currentIndex;
    currentPose = widget.poses![currentIndex!];
    poseName = currentPose!.title;
    videoUrl = currentPose!.videoUrl;
    poseNameDisplay = poseName![0].toUpperCase() + poseName!.substring(1);

    poseSubtitle =
        currentPose!.sub![0].toUpperCase() + currentPose!.sub!.substring(1);

    benefitList = currentPose!.benefits!.split('. ');

    poseImageUrl = currentPose!.image;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: currentIndex == 0
          ? NextWidget(
              trackName: widget.trackName,
              poses: poses,
              currentIndex: currentIndex,
            )
          : currentIndex == poses!.length - 1
              ? PrevWidget(
                  poses: poses,
                  trackName: widget.trackName,
                  currentIndex: currentIndex,
                )
              : PrevNextWidget(
                  poses: poses,
                  trackName: widget.trackName,
                  currentIndex: currentIndex,
                ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: PageScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      height: screenWidth * 0.8,
                      // child: Image.asset(
                      //   'assets/images/triangle.png',
                      //   fit: BoxFit.fitHeight,
                      // ),
                      child: poseImageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: poseImageUrl!,
                              placeholder: (context, url) => Container(
                                width: double.maxFinite,
                                height: screenWidth * 0.8,
                              ),
                              errorWidget: (context, url, error) => Container(),
                              fit: BoxFit.fitHeight,
                            )
                          : Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                'assets/images/triangle.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                    ),
                    _trackName == 'beginners'
                        ? Container()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'COMING SOON',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Palette.black.withOpacity(0.8),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '3 minutes',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Palette.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print('Play button tapped !');
                        if (videoUrl!.isNotEmpty) {
                          await Permission.camera.request();

                          var status = await Permission.camera.status;
                          if (status.isGranted) {
                            SystemChrome.setSystemUIOverlayStyle(
                                SystemUiOverlayStyle(
                              statusBarColor: Colors.white,
                              statusBarIconBrightness: Brightness.dark,
                            ));

                            final configBox = Hive.box('config');
                            String screenOrientation =
                                configBox.get(hiveScreenOrientation);

                            if (screenOrientation == defaultScreenOrientation) {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  // builder: (context) => LandmarkMLKitScreen(
                                  //   pose: currentPose,
                                  //   trackName: _trackName,
                                  // ),
                                  builder: (context) => OrientationScreen(
                                    currentPose: currentPose,
                                    trackName: _trackName,
                                  ),
                                ),
                              )
                                  .then((result) {
                                String? returnedString = result as String?;

                                if (returnedString != 'navigated') {
                                  print('Each Pose Page -> $returnedString');
                                  // Wakelock.disable();
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown,
                                  ]);

                                  SystemChrome.setEnabledSystemUIOverlays(
                                    SystemUiOverlay.values,
                                  );
                                  SystemChrome.setSystemUIOverlayStyle(
                                    SystemUiOverlayStyle(
                                      statusBarColor: Colors.transparent,
                                      statusBarIconBrightness: Brightness.dark,
                                    ),
                                  );
                                } else {
                                  print('Each Pose Page -> $returnedString');
                                }
                              });
                            } else {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => LandmarkMLKitScreen(
                                    pose: currentPose,
                                    trackName: _trackName,
                                    screenRotation: screenOrientation ==
                                            landscapeRightScreenOrientation
                                        ? NativeDeviceOrientation.landscapeRight
                                        : NativeDeviceOrientation.landscapeLeft,
                                  ),
                                  // builder: (context) => OrientationScreen(
                                  //   currentPose: currentPose,
                                  //   trackName: _trackName,
                                  // ),
                                ),
                              )
                                  .then((result) {
                                String? returnedString = result as String?;

                                if (returnedString != 'navigated') {
                                  print('Each Pose Page -> $returnedString');
                                  Wakelock.disable();
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown,
                                  ]);

                                  SystemChrome.setEnabledSystemUIOverlays(
                                    SystemUiOverlay.values,
                                  );
                                  SystemChrome.setSystemUIOverlayStyle(
                                    SystemUiOverlayStyle(
                                      statusBarColor: Colors.transparent,
                                      statusBarIconBrightness: Brightness.dark,
                                    ),
                                  );
                                } else {
                                  print('Each Pose Page -> $returnedString');
                                }
                              });
                            }
                          }

                          // TODO: handle the case if user denied the permission

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomWidget.customSnackBar(
                              content:
                                  'The $poseName pose is not yet available. Coming soon.',
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _trackName == 'beginners'
                              ? Palette.lightDarkShade
                              : Palette.lightDarkShade.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 16.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 36.0,
                              ),
                              Text(
                                'Play',
                                // maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    poseNameDisplay,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    poseSubtitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    'Some of the benefits of the $poseNameDisplay pose are as follows:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: Palette.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: benefitList.length,
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          // top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '•  ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                                color: Palette.black,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${benefitList[index]}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  color: Palette.lightDarkShade,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ));
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
