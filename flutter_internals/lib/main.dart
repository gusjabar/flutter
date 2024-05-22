import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/keys.dart';

//import 'package:flutter_internals/ui_updates_demo.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        // body: const UIUpdatesDemo(),
        body: const Keys(),
      ),
    );
  }
}
//if an element/widget change of the position flutter doesn't create new elements
//for optimization pourpuse. updating reference.
//flutter determines whether an element can be reused or not. Simply by taking a look at the type of
//the element, for ex. todoitem and if the type is in line with the type it finds i the widget tree in that position where the element is it's happy and 
//it keeps that element and just make sure to update the reference to the widget it found in the same place in the widget three.