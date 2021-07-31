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

  startRecognitionScript({
    @required String poseName,
    @required String trackName,
    Function onReceive,
  }) async {
    try {
      await client.connect();
      print("shell connected!");

      print("SSH Send --> POSE: $poseName, TRACK: $trackName");

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
              // if (output.contains("PID:")) {
              //   // print(output.substring(5));
              //   setState(() {
              //     outputDetails = "initialized";
              //     processId = output.substring(5).trim();
              //   });
              // } else if (output.contains("INFO:")) {
              //   // print(output.substring(6));
              //   setState(() {
              //     outputDetails = output.substring(6).trim();
              //   });
              // } else if (output.contains("RECOGNIZED:")) {
              //   // print(output.substring(12));
              //   setState(() {
              //     outputDetails = output.substring(12).trim();
              //   });
              // } else if (output.contains("KILL:")) {
              //   setState(() {
              //     outputDetails = "not initizlized";
              //   });
              //   await client.closeShell();
              //   print("shell closed!");
              //   await client.disconnect();
              //   print("shell disconnected!");
              // }
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
