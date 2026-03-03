import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/presentation/provider/recipe_provider.dart';
import 'package:recipe_book_app/presentation/widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: AppStrings.searchHint,
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              context.read<RecipeProvider>().searchRecipes(value);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<RecipeProvider>().clearSearch();
            },
          ),
        ],
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingSearch) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchRecipe.isEmpty) {
            if (_searchController.text.isEmpty) {
              return const Center(child: Text(AppStrings.typeToSearch));
            }
            return const Center(child: Text(AppStrings.noRecipesFound));
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: provider.searchRecipe.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: provider.searchRecipe[index]);
            },
          );
        },
      ),
    );
  }
}
