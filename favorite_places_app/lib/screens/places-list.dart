import 'package:favorite_places_app/screens/new_place.dart';
import 'package:flutter/material.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return PlacesListScreenState();
  }
}

class PlacesListScreenState extends State<PlacesListScreen> {
  void _addNew() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewPlace(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [IconButton(onPressed: _addNew, icon: const Icon(Icons.add))],
      ),
      body: const Text('Content here'),
    );

    return content;
  }
}
