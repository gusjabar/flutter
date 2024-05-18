import 'package:flutter/material.dart';
import 'package:roll_dice/custom_widget/styled_text.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      // {super.key, required this.color1, required this.color2});
      {
    super.key,
    required this.colors,
  });

  // final Color color1;
  // final Color color2;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Center(
          child: StyledText("Hello Miami (305)"),
        ));
  }
}
