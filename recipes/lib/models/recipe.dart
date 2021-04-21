import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String photoPath;
  @HiveField(2)
  final String cookTime;
  @HiveField(3)
  final String servings;

  Recipe(this.name, this.photoPath, this.cookTime, this.servings);
}