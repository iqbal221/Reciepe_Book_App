import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeDetails extends Recipe {
  final List<String> ingredients;
  final String instructions;
  final int readyInMinutes;
  final int servings;

  RecipeDetails({
    required super.id,
    required super.title,
    required super.image,
    required this.ingredients,
    required this.instructions,
    required this.readyInMinutes,
    required this.servings,
  });
}
