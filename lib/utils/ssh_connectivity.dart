import 'package:ssh/ssh.dart';

import '../secrets.dart';

class SSHConnectivity {
  SSHClient client = SSHClient(
    host: PiConfig.hostname,
    username: PiConfig.username,
    port: PiConfig.port,
    passwordOrKey: PiConfig.password,
  );

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
        await client.writeToShell("cd ~ && ./oak_check.sh\n");
      } catch (e) {
        onReceive("ERROR(2)");
      }
    } catch (e) {
      onReceive("ERROR(1)");
    }
  }

  startRecognitionScript({Function onReceive}) async {
    try {
      await client.connect();
      print("shell connected!");

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
        await client.writeToShell("cd ~ && ./oak_starter.sh\n");
      } catch (e) {
        onReceive("ERROR(2)");
      }
    } catch (e) {
      onReceive("ERROR(1)");
    }
  }

  stopRecognitionScript(String processId) async {
    await client.writeToShell(
      "cd ~ && ./oak_dispose.sh $processId\n",
    );
    client.disconnect();
  }
}
