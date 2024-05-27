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

  late Future<List<GroceryItem>> _loadedItems;

  bool _isLoading = true;
  String? _errorMessage;

  Future<List<GroceryItem>> _loadItems() async {
    final List<GroceryItem> tempList = [];
    final url = Uri.https(
        'flutter-prep-49765-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch grocery items. Try it late!');
    }
    //in the case where there isn't data on firebase use this check
    if (response.body == 'null') {
      return [];
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
    return tempList;
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
    _loadedItems = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: _addNewItem, icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          //excetud only once! on init state.
          future: _loadedItems,
          builder: (content, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              Center(
                child: Text(snapshot.error!.toString()),
              );
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No items added yet'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  _removeItem(snapshot.data![index]);
                },
                key: ValueKey(snapshot
                    .data![index].id), //uniquely identifier every list item.
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    height: 24,
                    width: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(snapshot.data![index].quantity.toString()),
                ),
              ),
            );
          }),
    );
  }
}
