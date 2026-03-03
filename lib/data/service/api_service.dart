import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/core/urls.dart';
import 'package:recipe_book_app/data/model/recipe_details_model.dart';
import 'package:recipe_book_app/data/model/recipe_model.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/domain/entities/recipe_details.dart';

class ApiService {
  // fetch recipe by category
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    final response = await http.get(
      Uri.parse(
        "${Urls.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&cuisine=${category}",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  // search recipe
  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse(
        '${Urls.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&query=$query',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  // fetch recipe details by id
  Future<RecipeDetails> getRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse('${Urls.baseUrl}/$id/information?apiKey=${AppStrings.apiKey}'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RecipeDetailsModel.fromJson(json);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
