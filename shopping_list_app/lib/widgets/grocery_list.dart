import 'package:flutter/material.dart';

import 'package:shopping_list_app/data/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _list = [];

  void _addNewItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        _list.add(newItem);
      });
    }
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _list.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet'),
    );

    if (_list.isNotEmpty) {
      content = ListView.builder(
        itemCount: _list.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_list[index]);
          },
          key: ValueKey(_list[index].id), //uniquely identifier every list item.
          child: ListTile(
            title: Text(_list[index].name),
            leading: Container(
              height: 24,
              width: 24,
              color: _list[index].category.color,
            ),
            trailing: Text(_list[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: _addNewItem, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
