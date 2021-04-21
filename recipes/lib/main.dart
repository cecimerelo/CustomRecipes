import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/recipe_form.dart';
import 'package:path_provider/path_provider.dart';

import 'common/recipe_summary_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(RecipeAdapter());
  runApp(const MyApp());

  final _ = await Hive.openBox('myRecipes');
  final myIngredientsBox = Hive.openBox('ingredients');
  final myStepsBox = Hive.openBox('steps');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'My recipes';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: FutureBuilder(
        future: Hive.openBox('myRecipes'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return RecipeViewWidget();
          }
          else
            return Scaffold();
        },
      ),
    );
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class RecipeViewWidget extends StatefulWidget {
  RecipeViewWidget({Key? key}) : super(key: key);

  @override
  _RecipeViewWidgetState createState() => _RecipeViewWidgetState();
}

class _RecipeViewWidgetState extends State<RecipeViewWidget> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
      ),
      body: Column(
        children: <Widget>[
          _buildRecipeList(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.of(context).push(_createRoute())},
        tooltip: 'Add a new Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }

  Center defaultBody() =>
      Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Your recipes will be shown here'),
      ));

  Widget _buildRecipeList(BuildContext context) {
    final myRecipesBox = Hive.box('myRecipes');

     return ValueListenableBuilder(
        valueListenable: Hive.box('myRecipes').listenable(),
        builder: (context, box, _) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: myRecipesBox.length,
              itemBuilder: (context, index) {
                final recipe = myRecipesBox.getAt(index) as Recipe;
                return new Container(
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RecipeSummaryWidget(
                            name: recipe.name,
                            photoPath: recipe.photoPath,
                            cookTime: recipe.cookTime,
                            servings: recipe.servings
                        ),
                      )
                    ]));
              });
        });
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RecipeFormWindow(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class RecipeFormWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Recipe"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            );
          },
        ),
      ),
      body: Center(
          child: ListView(
            children: [RecipeForm()],
      )),
    );
  }
}

