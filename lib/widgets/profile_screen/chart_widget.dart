import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sofia/utils/helper.dart';
import 'package:supercharged/supercharged.dart';

import 'package:sofia/model/attempts.dart';
import 'package:sofia/res/palette.dart';

import 'package:intl/intl.dart';

import 'chart_widget/asanas_info_widget.dart';

enum AnimProps {
  bar1,
  bar2,
  bar3,
  bar4,
  bar5,
  bar6,
  bar7,
}

class ChartWidget extends StatefulWidget {
  final List<Attempt> attempts;

  const ChartWidget({@required this.attempts});

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<TimelineValue<AnimProps>> _animation;

  int totalDurationThisWeekInEpoch = 0;
  int totalAttempts = 0;
  List<Attempt> retrievedAttempts = [];
  List<int> durationList = [0, 0, 0, 0, 0, 0, 0];
  int maxDuration = 1;

  @override
  void initState() {
    super.initState();

    retrievedAttempts = widget.attempts;
    totalAttempts = retrievedAttempts.length;

    int currentDurationInMilliseconds = 0;

    for (int i = 0; i < retrievedAttempts.length; i++) {
      print(
          'RETRIEVED: ${DateFormat.yMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(retrievedAttempts[i].dateTime))}');
      currentDurationInMilliseconds = retrievedAttempts[i].duration;
      totalDurationThisWeekInEpoch += currentDurationInMilliseconds;
      int currentWeekday = retrievedAttempts[i].weekday;
      print(currentWeekday);

      durationList[currentWeekday - 1] += currentDurationInMilliseconds;
    }
    // Finding the max value from the list to measure the realative bar heights
    maxDuration =
        durationList.reduce((curr, next) => curr > next ? curr : next);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation = TimelineTween<AnimProps>()
        .addScene(
          begin: 0.milliseconds,
          end: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar1,
          tween: Tween(begin: 0.0, end: durationList[0]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar2,
          tween: Tween(begin: 0.0, end: durationList[1]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar3,
          tween: Tween(begin: 0.0, end: durationList[2]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar4,
          tween: Tween(begin: 0.0, end: durationList[3]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar5,
          tween: Tween(begin: 0.0, end: durationList[4]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar6,
          tween: Tween(begin: 0.0, end: durationList[5]),
        )
        .addSubsequentScene(
          duration: 1.seconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.bar7,
          tween: Tween(begin: 0.0, end: durationList[6]),
        )
        .parent
        .animatedBy(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final int paddingSide = (16 * 2);

    final double chartWidth = screenWidth - paddingSide;
    final double chartHeight = screenWidth * (3 / 4) - paddingSide;

    final double eachSegmentLength = chartWidth / 8;
    // final int maxDuration = 52;

    // final List<int> durationList = [23, 32, 46, 52, 4, 18, 43];
    final List<String> dayList = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];

    return Column(
      children: [
        Container(
          width: chartWidth,
          height: chartHeight + 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => _buildAnimation(
                  context: context,
                  child: child,
                  chartHeight: chartHeight,
                ),
              ),
              Container(
                height: 2,
                width: chartWidth,
                decoration: BoxDecoration(
                  color: Palette.darkShade,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          width: chartWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dayList
                .map(
                  (day) => Container(
                    width: eachSegmentLength,
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: Palette.darkShade,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            SizedBox(width: 8.0),
            Text(
              'Total time: ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              Helper.generateTimeString(
                duration: Duration(milliseconds: totalDurationThisWeekInEpoch),
              ),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        AsanasInfoWidget(
          attempts: retrievedAttempts,
        ),
      ],
    );
  }

  Widget _buildAnimation({
    @required BuildContext context,
    @required Widget child,
    @required double chartHeight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: durationList.asMap().entries.map(
        (entry) {
          return Container(
            decoration: BoxDecoration(
              color: Palette.accentDarkPink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            // height: chartHeight * (bar / maxDuration),
            height: chartHeight *
                (_animation.value.get(AnimProps.values[entry.key]) /
                    maxDuration),
            width: 20,
          );
        },
      ).toList(),
    );
  }
}
