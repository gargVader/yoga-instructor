import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:sofia/res/string.dart';
import 'package:ssh/ssh.dart';

import '../secrets.dart';

class SSHConnectivity {
  final configBox = Hive.box('config');

  final String rootPath = '~/yoga-instructor-oak-server';

  checkAvailability({Function onReceive, @required SSHClient client}) async {
    try {
      await client.connect();
      print("shell connected!");

      try {
        await client.startShell(
          ptyType: "vanilla",
          callback: (dynamic res) async {
            String output = res;
            if (!output.contains("pi@raspberrypi:")) {
              onReceive(output);
            }
          },
        );
        print("shell started!");
        await client.writeToShell("cd $rootPath && ./oak_check.sh\n");
      } catch (e) {
        onReceive("ERROR(2)");
      }
    } catch (e) {
      onReceive("ERROR(1)");
    }
  }

  startLandmarkScript({Function onReceive, @required SSHClient client}) async {
    try {
      await client.connect();
      print("shell connected!");

      try {
        await client.startShell(
          ptyType: "vanilla",
          callback: (dynamic res) async {
            String output = res;
            // print('SSH: $output');
            if (!output.contains("pi@raspberrypi:")) {
              onReceive(output);
            }
          },
        );
        print("shell started!");
        await client.writeToShell(
          "cd $rootPath && ./oak_landmark.sh\n",
        );
      } catch (e) {
        onReceive("ERROR(2)");
      }
    } catch (e) {
      onReceive("ERROR(1)");
    }
  }

  startRecognitionScript({
    @required String poseName,
    @required String trackName,
    Function onReceive,
    @required SSHClient client,
  }) async {
    try {
      await client.connect();
      print("shell connected!");

      poseName = poseName.replaceAll(' ', '_');
      trackName = trackName.replaceAll(' ', '_');

      print("SSH Send --> POSE: $poseName, TRACK: $trackName)");

      try {
        await client.startShell(
          ptyType: "vanilla",
          callback: (dynamic res) async {
            String output = res;
            print('SSH: $output');
            // setState(() {
            //   verboseOutputDetails = output;
            // });
            if (!output.contains("pi@raspberrypi:")) {
              onReceive(output);
            }
          },
        );
        print("shell started!");
        await client.writeToShell(
          "cd $rootPath && ./oak_starter.sh $poseName $trackName\n",
        );
      } catch (e) {
        onReceive("ERROR(2)");
      }
    } catch (e) {
      onReceive("ERROR(1)");
    }
  }

  stopRecognitionScript({String processId, @required SSHClient client}) async {
    await client.writeToShell(
      "cd $rootPath && ./oak_dispose.sh $processId\n",
    );
    client.disconnect();
  }
}
