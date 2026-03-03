import 'dart:convert';

import 'package:recipe_book_app/data/model/recipe_model.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _favoritesKey = 'favorites';

  Future<List<Recipe>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson != null && favoritesJson.isNotEmpty) {
      final List decoded = jsonDecode(favoritesJson);
      return decoded.map((e) => RecipeModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    List<Recipe> currentFavorites = await getFavorites();

    final index = currentFavorites.indexWhere((r) => r.id == recipe.id);
    if (index >= 0) {
      currentFavorites.removeAt(index);
    } else {
      currentFavorites.add(recipe);
    }

    final List<Map<String, dynamic>> jsonList = currentFavorites.map((r) {
      return RecipeModel(id: r.id, title: r.title, image: r.image).toJson();
    }).toList();

    await prefs.setString(_favoritesKey, jsonEncode(jsonList));
  }

  Future<bool> isFavorite(int id) async {
    List<Recipe> currentFavorites = await getFavorites();
    return currentFavorites.any((r) => r.id == id);
  }
}
