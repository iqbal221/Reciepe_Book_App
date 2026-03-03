import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/service/api_service.dart';
import 'package:recipe_book_app/data/service/local_storage_service.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/domain/entities/recipe_details.dart';

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalStorageService _localStorageService = LocalStorageService();

  List<Recipe> _categoryRecipes = [];
  List<Recipe> get categoryRecipes => _categoryRecipes;
  bool _isLoadingCategory = false;
  bool get isLoadingCategory => _isLoadingCategory;

  List<Recipe> _searchRecipe = [];
  List<Recipe> get searchRecipe => _searchRecipe;
  bool _isLoadingSearch = false;
  bool get isLoadingSearch => _isLoadingSearch;

  RecipeDetails? _currentRecipeDetails;
  RecipeDetails? get currentRecipeDetails => _currentRecipeDetails;
  bool _isLoadingDetails = false;
  bool get isLoadingDetails => _isLoadingDetails;

  List<Recipe> _favoriteRecipes = [];
  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  RecipeProvider() {
    loadFavorites();
  }

  // fetch recipes by category
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

  // search recipes
  Future<void> searchRecipes(String query) async {
    _isLoadingSearch = true;
    notifyListeners();

    try {
      _searchRecipe = await _apiService.searchRecipes(query);
    } catch (e) {
      _searchRecipe = [];
    }
    _isLoadingSearch = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchRecipe = [];
    notifyListeners();
  }

  // fetch recipe details by id
  Future<void> fetchRecipeDetails(int id) async {
    _isLoadingDetails = true;
    _currentRecipeDetails = null;
    notifyListeners();
    try {
      _currentRecipeDetails = await _apiService.getRecipeDetails(id);
    } catch (e) {
      _currentRecipeDetails = null;
    }
    _isLoadingDetails = false;
    notifyListeners();
  }

  // fetch favorites from local storage
  Future<void> loadFavorites() async {
    _favoriteRecipes = await _localStorageService.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    await _localStorageService.toggleFavorite(recipe);
    await loadFavorites();
  }

  bool isFavorite(int id) {
    return _favoriteRecipes.any((r) => r.id == id);
  }
}
