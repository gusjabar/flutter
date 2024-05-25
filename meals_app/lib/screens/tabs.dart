import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  void _showInfoMessenger(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(message),
      ),
    );
  }

  void _toggleFavoriteMealStatus(Meal meal) {
    final isExist = _favoriteMeal.contains(meal);
    if (isExist) {
      setState(() {
        _favoriteMeal.remove(meal);
        _showInfoMessenger('Meal is not longer a favorite');
      });
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showInfoMessenger('Meal as a favorite');
      });
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if ('filters' == identifier) {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
              builder: (ctx) =>
                  FiltersScreen(currentFilters: _selectedFilter)));
      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeal = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeal,
      onFavoriteMeal: _toggleFavoriteMealStatus,
    );

    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onFavoriteMeal: _toggleFavoriteMealStatus,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
