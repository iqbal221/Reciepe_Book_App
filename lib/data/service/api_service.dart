import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/core/urls.dart';
import 'package:recipe_book_app/data/model/recipe_model.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';

class ApiService {
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
    }
  }
}
