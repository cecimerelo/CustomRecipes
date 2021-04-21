import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:recipes/common/recipe_view_complete.dart';
import 'package:recipes/main.dart';

class RecipeSummaryWidget extends StatelessWidget {
  RecipeSummaryWidget(
      {Key? key,
      this.name = '',
      this.photoPath = '',
      this.cookTime = '',
      this.servings = ''})
      : super(key: key);

  final String name;
  final String photoPath;
  final String cookTime;
  final String servings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_routeToRecipeView());
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage(photoPath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 70.0,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text(servings,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      Icon(Icons.group, color: Colors.white),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text(cookTime,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      Icon(Icons.access_alarm_rounded,
                                          color: Colors.white),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Route<Object?> _routeToRecipeView() {
    return CupertinoPageRoute(
        builder: (_) => RecipeViewCompleteWidget(name: name));
  }
}

