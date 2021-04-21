import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class RecipeViewCompleteWidget extends StatefulWidget {
  const RecipeViewCompleteWidget({ Key? key, this.name='' }) : super(key: key);

  final String name;

  @override
  _RecipeViewWidgetState createState() => _RecipeViewWidgetState();
}

class _RecipeViewWidgetState extends State<RecipeViewCompleteWidget> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              buildIngredientsList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              buildStepsList(),
            ],
          ),
        ));
  }

  Flexible buildIngredientsList() {
    final myRecipesBox = Hive.box('ingredients');
    final ingredients = myRecipesBox.get(widget.name);

    return new Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: new Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredients.length,
                    itemBuilder: (_, index) {
                      return new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 10.0),
                              child:
                              new Text("${index + 1}. ${ingredients[index]} "),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ));
  }

  buildStepsList() {
    final myRecipesBox = Hive.box('steps');
    final steps = myRecipesBox.get(widget.name);

    return new Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: new Card(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child:
                      new Text("${index + 1}. ${steps[index]} "),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}