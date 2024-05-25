import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onFavoriteMeal, required this.availableMeals});
  final List<Meal> availableMeals;
  final Function(Meal meal) onFavoriteMeal;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeal = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //push the screen on top the users screen.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeal,
          onFavoriteMeal: onFavoriteMeal,
        ),
      ),
    );
    //push new layer onto the stack
    //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20), //fixed to 2 columns
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(context, category),
          ),
      ],
    );
  }
}
