import 'package:flutter/material.dart';
import 'package:roll_dice/custom_widget/styled_text.dart';

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
          child: StyledText("Hello Miami (305)"),
        ));
  }
}
