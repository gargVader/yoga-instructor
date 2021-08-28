import 'package:flutter/material.dart';
import 'package:sofia/model/attempts.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/utils/helper.dart';

class AsanasInfoWidget extends StatelessWidget {
  const AsanasInfoWidget({
    Key? key,
    required this.attempts,
    this.textColor = Colors.black,
    this.subtitleColor = Colors.black54,
    this.countColor = Colors.white,
    this.backgroundColorExpanded = Palette.lightShade,
    this.enableSubtitle = true,
  }) : super(key: key);

  final List<Attempt> attempts;
  final Color textColor;
  final Color subtitleColor;
  final Color countColor;
  final Color backgroundColorExpanded;
  final bool enableSubtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          accentColor: textColor,
          unselectedWidgetColor: textColor,
        ),
        child: ExpansionTile(
          backgroundColor: backgroundColorExpanded.withOpacity(0.5),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Asanas',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    '${attempts.length}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: countColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          subtitle: enableSubtitle
              ? Text(
                  'Yoga poses performed this week',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: subtitleColor,
                  ),
                )
              : null,
          initiallyExpanded: false,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: attempts.length,
              itemBuilder: (context, index) {
                var poseName = attempts[index].pose![0].toUpperCase() +
                    attempts[index].pose!.substring(1);

                var durationString = Helper.generateTimeString(
                  duration: Duration(
                    milliseconds: attempts[index].duration!,
                  ),
                );

                var numberOfStars = attempts[index].stars.toString();

                var accuracy =
                    '${(attempts[index].accuracy! * 100).toStringAsFixed(0)}' +
                        '%';

                return ListTile(
                  title: Text(
                    poseName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    durationString,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor,
                    ),
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_border,
                            color: textColor,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            numberOfStars,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        accuracy,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
