import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DirectionRowWidget extends StatefulWidget {
  DirectionRowWidget({Key? key}) : super(key: key);
  final TextEditingController description = new TextEditingController();

  @override
  _DirectionRowWidgetState createState() => _DirectionRowWidgetState();
}

class _DirectionRowWidgetState extends State<DirectionRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          CupertinoTextFormFieldRow(
            maxLines: 5,
            placeholder: 'Enter your step description here',
            controller: widget.description,
          ),
        ]));
  }
}
