import 'package:flutter/foundation.dart';
import 'package:ssh/ssh.dart';

import '../secrets.dart';

class SSHConnectivity {
  SSHClient client = SSHClient(
    host: PiConfig.hostname,
    username: PiConfig.username,
    port: PiConfig.port,
    passwordOrKey: PiConfig.password,
  );

  final String rootPath = '~/yoga-instructor-oak-server';

  checkAvailability({Function onReceive}) async {
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

  startLandmarkScript({Function onReceive}) async {
    try {
      await client.connect();
      print("shell connected!");

      try {
        await client.startShell(
          ptyType: "vanilla",
          callback: (dynamic res) async {
            String output = res;
            print('SSH: $output');
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

  stopRecognitionScript(String processId) async {
    await client.writeToShell(
      "cd $rootPath && ./oak_dispose.sh $processId\n",
    );
    client.disconnect();
  }
}
