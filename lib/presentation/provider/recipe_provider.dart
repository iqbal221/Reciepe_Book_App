import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/service/api_service.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Recipe> _categoryRecipes = [];
  List<Recipe> get categoryRecipes => _categoryRecipes;
  bool _isLoadingCategory = false;
  bool get isLoadingCategory => _isLoadingCategory;

  Future<void> fetchRecipesByCategory(String category) async {
    _isLoadingCategory = true;
    notifyListeners();
    try {
      _categoryRecipes = await _apiService.getRecipesByCategory(category);
    } catch (e) {
      _categoryRecipes = [];
    }
    _isLoadingCategory = false;
    notifyListeners();
  }
}
