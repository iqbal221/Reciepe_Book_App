import 'package:recipe_book_app/domain/entities/recipe_details.dart';

class RecipeDetailsModel extends RecipeDetails {
  RecipeDetailsModel({
    required super.id,
    required super.title,
    required super.image,
    required super.ingredients,
    required super.instructions,
    required super.readyInMinutes,
    required super.servings,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    var extededIngredients = json['extendedIngredients'] as List? ?? [];
    List<String> ingredientsList = extededIngredients
        .map((ingredient) => ingredient['original'] as String)
        .toList();

    return RecipeDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      ingredients: ingredientsList,
      instructions: json['instructions'] as String,
      readyInMinutes: json['readyInMinutes'] as int,
      servings: json['servings'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'ingredients': ingredients,
      'instructions': instructions,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
    };
  }
}
