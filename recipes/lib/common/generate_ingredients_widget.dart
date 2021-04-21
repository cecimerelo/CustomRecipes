import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipes/common/ingredient_row_widget.dart';

class Ingredient {
  String ingredientName;
  String ingredientQuantity;
  String ingredientUnit;

  Ingredient(this.ingredientName, this.ingredientQuantity, this.ingredientUnit);
}

class GenerateIngredientsWidget extends StatefulWidget {
  GenerateIngredientsWidget({Key? key}) : super(key: key);

  late List<Ingredient> dynamicListOfIngredients;
  bool ingredientActive = true;

  @override
  _GenerateIngredientsWidgetState createState() =>
      _GenerateIngredientsWidgetState();
}

class _GenerateIngredientsWidgetState extends State<GenerateIngredientsWidget> {
  late IngredientRowWidget ingredient = new IngredientRowWidget();

  Icon floatingIcon = new Icon(Icons.add);

  void initState() {
    super.initState();
    widget.dynamicListOfIngredients = [];
  }

  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: new Card(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dynamicListOfIngredients.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text(
                          "${widget.dynamicListOfIngredients[index].ingredientQuantity} ${widget.dynamicListOfIngredients[index].ingredientUnit} of ${widget.dynamicListOfIngredients[index].ingredientName}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    return new Center(
      child: new Column(
        children: <Widget>[
          Column(mainAxisSize: MainAxisSize.min, children: [
            widget.dynamicListOfIngredients.length == 0
                ? ingredientForm()
                : result,
            widget.ingredientActive &&
                    widget.dynamicListOfIngredients.length != 0
                ? ingredientForm()
                : Container(),
          ]),
          CupertinoButton(onPressed: addIngredient, child: new Icon(Icons.add))
        ],
      ),
    );
  }

  ingredientForm() => new Center(
        child: new Column(
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: [
              ingredient,
              saveIngredientButton(),
            ]),
          ],
        ),
      );

  Padding saveIngredientButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CupertinoButton(
          onPressed: saveIngredient,
          child: const Text('Save'),
        ),
      );

  void saveIngredient() {
    Ingredient newIngredient = Ingredient(ingredient.ingredientName.text,
        ingredient.ingredientQuantity.text, ingredient.selectedUnit.name);
    widget.dynamicListOfIngredients.add(newIngredient);
    widget.ingredientActive = false;

    setState(() {});
  }

  addIngredient() {
    setState(() {});
    widget.ingredientActive = true;
    ingredient = new IngredientRowWidget();
  }
}
