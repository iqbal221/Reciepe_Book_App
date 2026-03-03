import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_book_app/presentation/screens/recipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(recipeId: recipe.id),
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: SizedBox(
          width: 168,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image with overlays
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      height: 158,
                      width: 168,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 158,
                        width: 300,
                        color: AppColors.grey200,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 158,
                        width: 168,
                        color: AppColors.grey200,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  // Rating Pill Overlay
                  Positioned(
                    top: 24,
                    left: 15,
                    child: Container(
                      height: 24,
                      width: 46,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:
                            AppColors.customOverlay, // Semi-transparent black
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.starColor,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Text(
                            AppStrings.defaultRating,
                            style: TextStyle(
                              color: AppColors.surface,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
