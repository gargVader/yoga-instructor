import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/res/string.dart';
import 'package:sofia/utils/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/widgets/oak_d_widgets/ssh_config_button.dart';
import 'package:sofia/widgets/profile_screen/chart_error_widget.dart';
import 'package:sofia/widgets/profile_screen/chart_initial_widget.dart';
import 'package:sofia/widgets/profile_screen/chart_retrieving_widget.dart';
import 'package:sofia/widgets/profile_screen/chart_widget.dart';
import 'package:sofia/widgets/profile_screen/settings_divider.dart';
import 'package:sofia/widgets/profile_screen/settings_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;
  String? displayName;
  String? userEmail;
  MyUser? userData;
  // int index = 10;
  late Box _configBox;

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final _profileFormKey = GlobalKey<FormState>();
  final _database = Database();

  bool _isUpdating = false;
  late bool _isDevModeEnabled;

  String? _nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    userData = Database.user;
    imageUrl = userData!.imageUrl;
    displayName = userData!.accountName;
    userEmail = userData!.email;

    _nameController = TextEditingController(text: displayName);
    _emailController = TextEditingController(text: userEmail);

    _configBox = Hive.box('config');
    _isDevModeEnabled = _configBox.get(hiveDevMode) ?? false;
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

    // final int paddingSide = (16 * 2);

    // final double chartWidth = screenWidth - paddingSide;
    // final double chartHeight = screenWidth * (3 / 4) - paddingSide;

    // final double eachSegmentLength = chartWidth / 8;
    // final int maxDuration = 52;

    // final List<int> durationList = [23, 32, 46, 52, 4, 18, 43];
    // final List<String> dayList = [
    //   'MON',
    //   'TUE',
    //   'WED',
    //   'THU',
    //   'FRI',
    //   'SAT',
    //   'SUN',
    // ];

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
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        barrierColor: Colors.transparent,
                        backgroundColor: Colors.black,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              _nameFocusNode.unfocus();
                              _emailFocusNode.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.white24,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Container(
                                            height: 5,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                            _isUpdating
                                                ? CircularProgressIndicator()
                                                : FlatButton(
                                                    onPressed: () async {
                                                      if (_profileFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        if (_nameController!
                                                                    .text !=
                                                                displayName ||
                                                            _emailController!
                                                                    .text !=
                                                                userEmail) {
                                                          _nameFocusNode
                                                              .unfocus();
                                                          _emailFocusNode
                                                              .unfocus();

                                                          setState(() {
                                                            _isUpdating = true;
                                                          });

                                                          await _database
                                                              .updateUserData(
                                                            name:
                                                                _nameController!
                                                                    .text,
                                                            email:
                                                                _emailController!
                                                                    .text,
                                                          );

                                                          setState(() {
                                                            _isUpdating = false;
                                                          });

                                                          context
                                                              .read(
                                                                  retrieveUserNotifierProvider
                                                                      .notifier)
                                                              .retrieveUser();
                                                        }

                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: Text(
                                                      'SAVE',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Form(
                                      key: _profileFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Update profile',
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 24.0),
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          TextFormField(
                                            controller: _nameController,
                                            focusNode: _nameFocusNode,
                                            validator: _nameValidator,
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (value) {
                                              _nameFocusNode.unfocus();
                                              _emailFocusNode.requestFocus();
                                            },
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          TextField(
                                            controller: _emailController,
                                            focusNode: _emailFocusNode,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    icon: Icon(Icons.edit),
                  ),
                )
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                                        child: Image.network(imageUrl!),
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
                                  displayName!,
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
                                  userEmail!,
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
                    userData!.accuracy != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
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
                                          '${userData!.stars} stars',
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
                                  color: Palette.black.withOpacity(0.2),
                                  height: 40,
                                  width: 2,
                                ),
                                Container(
                                  width: screenWidth / 2.2,
                                  child: Center(
                                    child: Text(
                                      '${(userData!.accuracy! * 100).toStringAsFixed(1)} % accuracy',
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
                    SizedBox(height: 32.0),
                    Center(
                      child: Text(
                        'This week',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Consumer(builder: (context, watch, child) {
                      final state = watch(
                        retrieveAttemptsNotifierProvider,
                      );

                      return state.when(
                        () => ChartInitialWidget(),
                        retrieving: () => ChartRetrievingWidget(),
                        retrieved: (attempts) => ChartWidget(
                          attempts: attempts,
                        ),
                        error: (message) => ChartErrorWidget(),
                      );
                    }),
                    SizedBox(height: 32.0),
                    ValueListenableBuilder(
                      valueListenable: _configBox.listenable(),
                      builder: (context, Box currentBox, widget) => Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Targets',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          SettingsTile(
                            title: 'Duration',
                            description:
                                'You can set this daily target duration for the yoga sessions to remain consistent everyday.',
                            hiveKey: hiveDuration,
                            hiveValue: '${currentBox.get(hiveDuration)}',
                            textFieldSuffixString: 'min',
                          ),
                          SettingsDivider(),
                          SettingsTile(
                            title: 'Number of asanas',
                            description:
                                'Set the number of yoga asanas you want to perform each day.',
                            hiveKey: hiveAsanas,
                            hiveValue: '${currentBox.get(hiveAsanas)}',
                          ),
                          SettingsDivider(),
                          SettingsTile(
                            title: 'Accuracy',
                            description:
                                'Set the average accuracy of the yoga postures that you want to achieve each day',
                            hiveKey: hiveAccuracy,
                            hiveValue: '${currentBox.get(hiveAccuracy)}',
                            textFieldSuffixString: '%',
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            // height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16.0,
                                      8.0,
                                      0.0,
                                      8.0,
                                    ),
                                    child: Text(
                                      'Turn on Dev mode to configure the external device SSH settings',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Switch(
                                  activeTrackColor: Colors.green,
                                  inactiveTrackColor: Colors.red,
                                  value: _isDevModeEnabled,
                                  onChanged: (newValve) {
                                    _configBox.put(hiveDevMode, newValve);
                                    setState(() {
                                      _isDevModeEnabled = newValve;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          SettingsTile(
                            title: 'Hold duration',
                            description:
                                'Set the duration for which the virtual yoga instructor will check your posture accuracy.',
                            hiveKey: hiveHoldDuration,
                            hiveValue: '${currentBox.get(hiveHoldDuration)}',
                            textFieldSuffixString: 'secs',
                          ),
                          SettingsDivider(),
                          SettingsTile(
                            title: 'Camera',
                            description:
                                'Set which camera to use for the detection of posture accuracy. For increased precission you can use the OAK-D camera.',
                            hiveKey: hiveCamera,
                            hiveValue: '${currentBox.get(hiveCamera)}',
                          ),
                          // SettingsDivider(),
                          // SettingsTile(
                          //   title: 'RasPi root path',
                          //   description:
                          //       'Set the root path of the Raspberry Pi where the scripts are stored.\nDisclaimer: Default is already set to correct path.',
                          //   hiveKey: hiveRaspiPath,
                          //   hiveValue: '${currentBox.get(hiveRaspiPath)}',
                          // ),
                          SettingsDivider(),
                        ],
                      ),
                    ),
                    _isDevModeEnabled
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onTap: null,
                                title: Text(
                                  'External device',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: SSHConfigButton(),
                              ),
                              SettingsDivider(),
                            ],
                          )
                        : Container(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onTap: () {},
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SettingsDivider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onTap: () {},
                      title: Text(
                        'Terms & conditions',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SettingsDivider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onTap: () {},
                      title: Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SettingsDivider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onTap: () {},
                      title: Text(
                        'Contact us',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            'Log out',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class SettingsTile extends StatefulWidget {
//   final String title;
//   final String description;
//   final String hiveKey;
//   final String textFieldSuffixString;

//   const SettingsTile({
//     @required this.title,
//     @required this.description,
//     @required this.hiveKey,
//     @required this.textFieldSuffixString,
//   });

//   @override
//   _SettingsTileState createState() => _SettingsTileState();
// }

// class _SettingsTileState extends State<SettingsTile> {
//   TextEditingController _textController = TextEditingController();

//   Box _configBox;
//   String _value;

//   @override
//   void initState() {
//     super.initState();
//     _configBox = Hive.box('config');
//     _value = _configBox.get(widget.hiveKey);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           barrierColor: Colors.transparent,
//           backgroundColor: Colors.black,
//           isScrollControlled: true,
//           builder: (context) {
//             return Padding(
//               padding: MediaQuery.of(context).viewInsets,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     color: Colors.white24,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(),
//                         FlatButton(
//                           onPressed: () {
//                             if (_textController.text != null &&
//                                 _textController.text != '') {
//                               _configBox.put(
//                                   widget.hiveKey, _textController.text);
//                             }
//                           },
//                           child: Text(
//                             'SAVE',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text(
//                           'Set ${widget.title.toLowerCase()}',
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 24.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.title,
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                             Container(
//                               width: 80,
//                               child: TextField(
//                                 controller: _textController,
//                                 autofocus: true,
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 decoration: InputDecoration(
//                                   suffix: Text(
//                                     widget.textFieldSuffixString, // hour
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 24.0),
//                         Text(
//                           widget
//                               .description, //'You can set this daily target duration for the yoga sessions to remain consistent everyday.',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w300,
//                             color: Colors.white70,
//                           ),
//                         ),
//                         SizedBox(height: 16.0),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//       title: Text(
//         widget.title,
//         style: TextStyle(
//           fontSize: 18.0,
//           fontWeight: FontWeight.w400,
//           color: Colors.black,
//         ),
//       ),
//       trailing: Text(
//         _value == null
//             ? 'not set'
//             : '$_value ${widget.textFieldSuffixString}', // '1 hour', // Retrieved from hive
//         style: TextStyle(
//           fontSize: 18.0,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
