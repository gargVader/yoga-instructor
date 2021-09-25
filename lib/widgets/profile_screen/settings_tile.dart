import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final String description;
  final String hiveKey;
  final String hiveValue;
  final String textFieldSuffixString;

  const SettingsTile({
    required this.title,
    required this.description,
    required this.hiveKey,
    required this.hiveValue,
    this.textFieldSuffixString = '',
  });

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  TextEditingController? _textController;

  late Box _configBox;
  // String _value;

  @override
  void initState() {
    super.initState();
    _configBox = Hive.box('config');
    // _value = _configBox.get(widget.hiveKey);
    _textController = TextEditingController(text: widget.hiveValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onTap: () {
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
            return Padding(
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
                              onPressed: () {
                                if (_textController!.text != null &&
                                    _textController!.text != '') {
                                  _configBox.put(
                                      widget.hiveKey, _textController!.text);
                                  Navigator.of(context).pop();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Set ${widget.title.toLowerCase()}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                            Container(
                              width: 80,
                              child: TextField(
                                controller: _textController,
                                autofocus: true,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  suffix: Text(
                                    widget.textFieldSuffixString, // hour
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          widget
                              .description, //'You can set this daily target duration for the yoga sessions to remain consistent everyday.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      trailing: Text(
        widget.hiveValue == null
            ? 'not set'
            : '${widget.hiveValue} ${widget.textFieldSuffixString}', // '1 hour', // Retrieved from hive
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
