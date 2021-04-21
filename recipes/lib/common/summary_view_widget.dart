import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/common/summary_form_widdget.dart';
import 'package:recipes/models/recipe.dart';
import 'package:path/path.dart';

class SummaryViewWidget extends StatefulWidget {
  SummaryViewWidget({Key? key, required this.recipeName}) : super(key: key);

  final String recipeName;

  @override
  _SummaryViewWidgetState createState() => _SummaryViewWidgetState();
}

class _SummaryViewWidgetState extends State<SummaryViewWidget> {
  SummaryForm summaryForm = new SummaryForm();
  final picker = ImagePicker();
  late File image = File("/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: Center(
          child: Column(
          children: [
            summaryForm,
            _recipePhotoWidget(context),
            saveStepButton(context)
          ],
      )),
    );
  }

  Padding _recipePhotoWidget(BuildContext context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Recipe Photo'),
                  Center(
                      child: image.path != '/'
                          ? photoContainer(context)
                          : photoIconContainer(context))
                ]),
              );

  Future getImageFromCamera() async {
    PickedFile pickedFile =
    (await picker.getImage(source: ImageSource.camera))!;
    setState(() {
      image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    PickedFile pickedFile =
    (await picker.getImage(source: ImageSource.gallery))!;

    setState(() {
      image = File(pickedFile.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Padding photoContainer(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Expanded(
        child: Center(
            child: Image.file(image),
          ),
      ),
      );

  Padding photoIconContainer(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: FittedBox(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: Container(
                child: Icon(Icons.add_a_photo, color: CupertinoColors.systemGrey)),
          )));


  Padding saveStepButton(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: CupertinoButton.filled(
      child: const Text('Save Recipe'),
      onPressed: () => saveRecipe(context),
    ),
  );

  saveRecipe(BuildContext context) async{
    String filePath = await getFilePath();
    final File aux = await image.copy(filePath);

    Recipe recipe = Recipe(widget.recipeName, filePath,
        summaryForm.cookTime.text, summaryForm.servings.text);
    final myRecipesBox = Hive.box('myRecipes');
    myRecipesBox.add(recipe);

    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final fileName = basename(image.path);

    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$fileName';

    return filePath;
  }

}
