import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 25, 2, 80),
              Color.fromARGB(255, 45, 7, 98)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: const Center(
              child: Text("Hello Miami",
                  style: TextStyle(color: Colors.white, fontSize: 28)),
            )),
      ),
    ),
  );
}
