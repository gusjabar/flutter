import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'dart:convert';
import 'package:shopping_list_app/data/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _list = [];
  bool _isLoading = true;
  String? _errorMessage;

  void _loadItems() async {
    final List<GroceryItem> tempList = [];
    final url = Uri.https(
        'flutter-prep-49765-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        setState(() {
          _errorMessage = "Something went wrong!";
          return;
        });
      }
      //in the case where there isn't data on firebase use this check
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> list = json.decode(response.body);
      for (final item in list.entries) {
        final cat = categories.entries
            .firstWhere((c) => c.value.title == item.value['category'])
            .value;
        tempList.add(
          GroceryItem(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: cat),
        );
      }
      setState(() {
        _list = tempList;
        _isLoading = false;
      });
    } catch (e, s) {
      setState(() {
        _errorMessage =
            'Something went wrong! \nException details:\n $e \n Stack trace:\n $s';
        return;
      });
    }
  }

  void _addNewItem() async {
    final data = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (data != null) {
      setState(() {
        _list.add(data);
      });
    }

    //  _loadItems();
  }

  void _removeItem(GroceryItem item) async {
    final index = _list.indexOf(item);
    setState(() {
      _list.remove(item);
    });
    final url = Uri.https('flutter-prep-49765-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode != 200) {
      setState(() {
        _list.insert(index, item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

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

    if (_errorMessage != null) {
      content = Center(
        child: Text(_errorMessage!),
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
