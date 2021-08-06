import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sofia/res/string.dart';
import 'package:ssh/ssh.dart';

import '../../secrets.dart';

import 'package:supercharged/supercharged.dart';

class SSHConfigButton extends StatefulWidget {
  final Function(SSHClient client) onReceive;

  const SSHConfigButton({this.onReceive});

  @override
  _SSHConfigButtonState createState() => _SSHConfigButtonState();
}

class _SSHConfigButtonState extends State<SSHConfigButton> {
  TextEditingController _sshHostname;
  TextEditingController _sshUsername;
  TextEditingController _sshPort;
  TextEditingController _sshPassword;

  final FocusNode _hostnameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _portFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final configBox = Hive.box('config');
  final _sshFormKey = GlobalKey<FormState>();

  String _hostnameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Hostname can\'t be empty';
    }
    return null;
  }

  String _usernameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Username can\'t be empty';
    }
    return null;
  }

  String _portValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Port can\'t be empty';
    }
    return null;
  }

  String _passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    String currentHostname = configBox.get(hiveHostName) ?? PiConfig.hostname;
    String currentUsername = configBox.get(hiveUsername) ?? PiConfig.username;
    int currentPort = configBox.get(hivePort) ?? PiConfig.port;
    String currentPassword = configBox.get(hivePassword) ?? PiConfig.password;

    _sshHostname = TextEditingController(text: currentHostname);
    _sshUsername = TextEditingController(text: currentUsername);
    _sshPort = TextEditingController(text: currentPort.toString());
    _sshPassword = TextEditingController(text: currentPassword);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
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
                _hostnameFocusNode.unfocus();
                _usernameFocusNode.unfocus();
                _portFocusNode.unfocus();
                _passwordFocusNode.unfocus();
              },
              child: SingleChildScrollView(
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
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                FlatButton(
                                  onPressed: () async {
                                    _hostnameFocusNode.unfocus();
                                    _usernameFocusNode.unfocus();
                                    _portFocusNode.unfocus();
                                    _passwordFocusNode.unfocus();

                                    if (_sshFormKey.currentState.validate()) {
                                      configBox.put(
                                          hiveHostName, _sshHostname.text);
                                      configBox.put(
                                          hiveUsername, _sshUsername.text);
                                      configBox.put(
                                          hivePort, _sshPort.text.toInt());
                                      configBox.put(
                                          hivePassword, _sshPassword.text);

                                      Navigator.of(context).pop();

                                      SSHClient client = SSHClient(
                                        host: configBox.get(hiveHostName),
                                        username: configBox.get(hiveUsername),
                                        port: configBox.get(hivePort),
                                        passwordOrKey:
                                            configBox.get(hivePassword),
                                      );

                                      widget.onReceive(client);
                                    }
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
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
                          key: _sshFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'SSH Configuration',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'Hostname',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              TextFormField(
                                controller: _sshHostname,
                                focusNode: _hostnameFocusNode,
                                validator: _hostnameValidator,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  _hostnameFocusNode.unfocus();
                                  _usernameFocusNode.requestFocus();
                                },
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              TextFormField(
                                controller: _sshUsername,
                                focusNode: _usernameFocusNode,
                                validator: _usernameValidator,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Port',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              TextFormField(
                                controller: _sshPort,
                                focusNode: _portFocusNode,
                                validator: _portValidator,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              TextFormField(
                                controller: _sshPassword,
                                focusNode: _passwordFocusNode,
                                validator: _passwordValidator,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
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
              ),
            );
          },
        );
      },
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Configure SSH',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
