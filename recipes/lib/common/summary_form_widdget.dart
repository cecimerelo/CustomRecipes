import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class SummaryForm extends StatefulWidget {
  SummaryForm({Key? key}) : super(key: key);

  final TextEditingController cookTime = new TextEditingController();
  final TextEditingController servings = new TextEditingController();

  @override
  _SummaryFormState createState() => _SummaryFormState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SummaryFormState extends State<SummaryForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Center(
          child: Column(children: [
            CupertinoFormSection(header: Text('Summary'), children: <Widget>[
              CupertinoTextFormFieldRow(
                placeholder: 'Cook time',
                controller: widget.cookTime,
              ),
              CupertinoTextFormFieldRow(
                placeholder: 'Servings',
                controller: widget.servings,
              )
            ]),
          ]),
    ));
  }
}
