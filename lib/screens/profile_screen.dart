import 'package:flutter/material.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/utils/database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imageUrl;
  String displayName;
  String userEmail;
  User userData;

  @override
  void initState() {
    super.initState();
    userData = Database.user;
    imageUrl = userData.imageUrl;
    displayName = userData.accountName;
    userEmail = userData.email;
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    // ));

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 4,
              centerTitle: false,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: IconButton(
                  splashColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Palette.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.black,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Row(
                      children: [
                        imageUrl != null
                            ? Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  border: Border.all(
                                    color: Palette.accentDarkPink,
                                    width: 3.0,
                                  ),
                                ),
                                child: Hero(
                                  tag: 'profile_pic',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: SizedBox(
                                      width: 38.0,
                                      child: Image.network(imageUrl),
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Container(
                                  color: Palette.lightDarkShade,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.person,
                                      color: Palette.lightShade,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.black,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Palette.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  userData.accuracy != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: screenWidth / 2.2,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star_border,
                                        color: Palette.black.withOpacity(0.8),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        '${userData.stars} stars',
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
                              ),
                              Container(
                                color: Palette.black.withOpacity(0.4),
                                height: 40,
                                width: 2,
                              ),
                              Container(
                                width: screenWidth / 2.2,
                                child: Center(
                                  child: Text(
                                    '${(userData.accuracy * 100).toStringAsFixed(1)} % accuracy',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      color: Palette.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
