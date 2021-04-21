import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:recipes/common/generate_ingredients_widget.dart';

import 'common/generate_directions_widget.dart';
import 'common/summary_view_widget.dart';

/// This is the stateful widget that the main application instantiates.
class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RecipeFormState extends State<RecipeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController recipeTitle = new TextEditingController();

  GenerateIngredientsWidget generateIngredientsWidget = new GenerateIngredientsWidget();
  GenerateDirectionsWidget generateDirectionsWidget = new GenerateDirectionsWidget();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            CupertinoFormSection(
              children: <Widget>[
                CupertinoTextFormFieldRow(
                  placeholder: 'Recipe Title',
                  controller: recipeTitle,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Title for the recipe';
                    }
                    return null;
                  },
                ),
              ],
            ),
            CupertinoFormSection(
                header: Text('Ingredients'),
                children: <Widget>[generateIngredientsWidget]),
            CupertinoFormSection(
                header: Text('Directions'),
                children: <Widget>[generateDirectionsWidget]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CupertinoButton.filled(
                onPressed: () => {
                  if (_formKey.currentState!.validate())
                    {
                      _saveIngredients(),
                      saveSteps(),
                      Navigator.of(context).push(_addSummaryOfRecipe())
                    }
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _addSummaryOfRecipe() {
    return CupertinoPageRoute(
        builder: (_) => SummaryViewWidget(recipeName: recipeTitle.text));
  }

  _saveIngredients() async {
    final ingredientBox = Hive.box('ingredients');
    List<String> ingredients = [];

    for (var i = 0; i < generateIngredientsWidget.dynamicListOfIngredients.length; i++) {
      var ingredient = generateIngredientsWidget.dynamicListOfIngredients[i];
      final String ingredientDescription =
          "${ingredient.ingredientQuantity} ${ingredient.ingredientUnit} of ${ingredient.ingredientName}";
      ingredients.add(ingredientDescription);
    }

    ingredientBox.put(recipeTitle.text, ingredients);
    }

  saveSteps() {
    final stepBox = Hive.box('steps');
    List<String> steps = [];

    // for (var i = 0; i < generateDirectionsWidget.dynamicListOfSteps.length; i++) {
    //   var ingredient = generateDirectionsWidget.dynamicListOfSteps[i];
    //   steps.add(ingredientDescription);
    // }

    stepBox.put(recipeTitle.text, generateDirectionsWidget.dynamicListOfSteps);

  }
}

