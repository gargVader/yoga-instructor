import 'package:flutter/material.dart';

import 'package:sofia/model/attempts.dart';
import 'package:sofia/res/palette.dart';

class ChartWidget extends StatefulWidget {
  final List<Attempt> attempts;

  const ChartWidget({@required this.attempts});

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<int> durationList = [0, 0, 0, 0, 0, 0, 0];
  int maxDuration = 1;

  @override
  void initState() {
    super.initState();

    List<Attempt> retrievedAttempts = widget.attempts;

    int currentDurationInMilliseconds = 0;

    for (int i = 0; i < retrievedAttempts.length; i++) {
      currentDurationInMilliseconds = retrievedAttempts[i].duration;
      int currentWeekday = retrievedAttempts[i].weekday;
      print(currentWeekday);

      durationList[currentWeekday - 1] += currentDurationInMilliseconds;
    }
    // Finding the max value from the list to measure the realative bar heights
    maxDuration =
        durationList.reduce((curr, next) => curr > next ? curr : next);
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
          // height: chartHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: durationList.map((bar) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Palette.accentDarkPink,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    height: chartHeight * (bar / maxDuration),
                    width: 20,
                  );
                }).toList(),
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
        )
      ],
    );
  }
}
