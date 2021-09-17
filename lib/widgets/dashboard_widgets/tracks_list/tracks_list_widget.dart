import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_track_page.dart';

class TracksListWidget extends StatelessWidget {
  final List<Track> tracks;

  const TracksListWidget({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: tracks.length,
      separatorBuilder: (context, index) => SizedBox(height: 32.0),
      itemBuilder: (_, index) {
        Track track = tracks[index];
        String trackName = track.name!;
        String trackDescription = track.desc!;

        // ------------------------------------------------
        // Track Card - START
        // ------------------------------------------------
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EachTrackPage(track: track),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Palette.mediumShade,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: trackName == 'beginners'
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ------------------------------------------------
                          // Coming Soon banner - START
                          // ------------------------------------------------
                          trackName == 'beginners'
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Palette.darkShade,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16.0,
                                      5.0,
                                      16.0,
                                      5.0,
                                    ),
                                    child: Text(
                                      'COMING SOON',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                          // ------------------------------------------------
                          // Coming Soon banner - END
                          // ------------------------------------------------
                          SizedBox(height: 4.0),
                          // ------------------------------------------------
                          // Track Name - START
                          // ------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              trackName[0].toUpperCase() +
                                  trackName.substring(1) +
                                  ' track',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.black,
                              ),
                            ),
                          ),
                          // ------------------------------------------------
                          // Track Name - END
                          // ------------------------------------------------
                        ],
                      ),
                      // ------------------------------------------------
                      // Play Button - START
                      // ------------------------------------------------
                      InkWell(
                        onTap: () {
                          print('Play button tapped !');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: trackName == 'beginners'
                                ? Palette.lightDarkShade
                                : Palette.lightDarkShade.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 36.0,
                            ),
                          ),
                        ),
                      ),
                      // ------------------------------------------------
                      // Play Button - END
                      // ------------------------------------------------
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // ------------------------------------------------
                  // Track Description - START
                  // ------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 24.0,
                    ),
                    child: Text(
                      trackDescription,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  // ------------------------------------------------
                  // Track Description - END
                  // ------------------------------------------------
                ],
              ),
            ),
          ),
        );
        // ------------------------------------------------
        // Track Card - END
        // ------------------------------------------------
      },
    );
  }
}
