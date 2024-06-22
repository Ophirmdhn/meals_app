import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screen/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key, 
    required this.onToggleFavorite
  });

  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
      .where((meal) => meal.categories.contains(category.id))
      .toList();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MealsScreen(
        title: category.title,
        meals: filteredMeals, 
        onToggleFavorite: onToggleFavorite,
        )
      )
    );
  }
  // sama dengan
  // Navigator.push(context, route)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category, 
              onSelectCategory: () { 
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}