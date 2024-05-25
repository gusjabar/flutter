import 'package:flutter/material.dart';
import 'package:meals_app/widgets/drawer_menu_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.85)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 14),
                Text(
                  'Coooking Up!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          DrawerMenuItem(
              title: 'Meal',
              icon: Icons.restaurant,
              onTap: () {
                onSelectScreen('meals');
              }),
          DrawerMenuItem(
              title: 'Filters',
              icon: Icons.settings,
              onTap: () {
                onSelectScreen('filters');
              }),
        ],
      ),
    );
  }
}
