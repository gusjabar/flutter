import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(),
      ),
    ),
  );
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 25, 2, 80),
          Color.fromARGB(255, 45, 7, 98)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: const Center(
          child: Text("Hello Miami",
              style: TextStyle(color: Colors.white, fontSize: 28)),
        ));
  }
}
