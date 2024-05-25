import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealProvider extends StateNotifier<List<Meal>> {
  FavoritesMealProvider() : super([]);

  bool toggleFavoriteStatus(Meal meal) {
    //state is inmutable
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealProvider, List<Meal>>((ref) {
  return FavoritesMealProvider();
});
