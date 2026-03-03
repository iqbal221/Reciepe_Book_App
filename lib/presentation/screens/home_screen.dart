import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/core/urls.dart';
import 'package:recipe_book_app/presentation/provider/recipe_provider.dart';
import 'package:recipe_book_app/presentation/screens/search_screen.dart';
import 'package:recipe_book_app/presentation/widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    'Italian',
    'Mexican',
    'Asian',
    'American',
    'Indian',
  ];
  String _selectedCategory = 'Italian';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipesByCategory(_selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 8,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                color: AppColors.surface,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: CircleAvatar(
                        backgroundColor: AppColors.surface,
                        backgroundImage: const NetworkImage(
                          Urls.profileImageUrl,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeBack,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          AppStrings.letsCook,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.black,
                        size: 30,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.categories,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              _buildCategoryList(),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<RecipeProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoadingCategory) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (provider.categoryRecipes.isEmpty) {
                      return const Center(
                        child: Text(AppStrings.noRecipesFound),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categoryRecipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          recipe: provider.categoryRecipes[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                if (_selectedCategory == category) return;

                setState(() {
                  _selectedCategory = category;
                });

                context.read<RecipeProvider>().fetchRecipesByCategory(category);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? AppColors.surface : AppColors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
