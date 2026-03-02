import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({required super.id, required super.title, required super.image});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image};
  }
}
