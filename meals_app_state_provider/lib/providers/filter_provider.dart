import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterProvider extends StateNotifier<Map<Filter, bool>> {
  FilterProvider()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterProvider, Map<Filter, bool>>((ref) {
  return FilterProvider();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final filter = ref.watch(filterProvider);
  return meals.where((meal) {
    if (filter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
