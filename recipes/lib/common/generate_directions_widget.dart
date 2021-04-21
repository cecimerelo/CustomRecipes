import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipes/common/direction_row_widget.dart';

class GenerateDirectionsWidget extends StatefulWidget {
  GenerateDirectionsWidget({Key? key}) : super(key: key);

  late List<String> dynamicListOfSteps;
  bool descriptionActive = true;

  @override
  _GenerateDirectionsWidgetState createState() =>
      _GenerateDirectionsWidgetState();
}

class _GenerateDirectionsWidgetState extends State<GenerateDirectionsWidget> {
  late DirectionRowWidget step = new DirectionRowWidget();
  Icon floatingIcon = new Icon(Icons.add);

  void initState() {
    super.initState();
    widget.dynamicListOfSteps = [];
  }

  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: new Card(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dynamicListOfSteps.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text(
                          "${index + 1}. ${widget.dynamicListOfSteps[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    return new Container(
      child: new Column(
        children: <Widget>[
          Column(mainAxisSize: MainAxisSize.min, children: [
            widget.dynamicListOfSteps.length == 0 ? stepForm() : result,
            widget.descriptionActive && widget.dynamicListOfSteps.length != 0
                ? stepForm()
                : Container(),
          ]),
          CupertinoButton(onPressed: addStep, child: new Icon(Icons.add))
        ],
      ),
    );
  }

  addStep() {
    setState(() {});
    widget.descriptionActive = true;
    step = new DirectionRowWidget();
  }

  stepForm() => new Center(
        child: new Column(
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: [
              step,
              saveStepButton(),
            ]),
          ],
        ),
      );

  Padding saveStepButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CupertinoButton(
          onPressed: saveStep,
          child: const Text('Save'),
        ),
      );

  void saveStep() {
    widget.dynamicListOfSteps.add(step.description.text);
    widget.descriptionActive = false;

    setState(() {});
  }
}
