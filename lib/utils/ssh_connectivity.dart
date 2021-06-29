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
}
