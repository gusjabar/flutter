import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: (LinearGradient(colors: [
            Color.fromRGBO(103, 2, 110, 1),
            Color.fromRGBO(217, 81, 227, 1)
          ])),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  "assets/images/quiz-logo.png",
                  width: 300,
                ),
              ),
              const Text(
                "Learn Flutter",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_right),
                  label: const Text("Start Quiz"),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 248, 246, 246),
                      backgroundColor: const Color.fromARGB(255, 68, 1, 70)),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  ));
}
