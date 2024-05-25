import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});
  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenSate();
  }
}

class _FilterScreenSate extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  // void _setScreen(String identifier) {
  //   Navigator.of(context).pop();
  //   if ('meals' == identifier) {
  //     //push put a new page on the screen
  //     //pushReplacement currently active screen.
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (ctx) => const TabsScreen(),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      //drawer: MainDrawer(onSelectScreen: _setScreen),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (value) => {
                setState(() {
                  _glutenFreeFilterSet = value;
                }),
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (value) => {
                setState(() {
                  _lactoseFreeFilterSet = value;
                }),
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (value) => {
                setState(() {
                  _vegetarianFilterSet = value;
                }),
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (value) => {
                setState(() {
                  _veganFilterSet = value;
                }),
              },
              title: Text(
                'Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            )
          ],
        ),
      ),
    );
  }
}
