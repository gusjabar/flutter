import 'package:flutter/material.dart';
import 'package:roll_dice/custom_widget/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
      : color1 = const Color.fromARGB(255, 91, 73, 132),
        color2 = const Color.fromARGB(255, 45, 7, 98);

  final Color color1;
  final Color color2;

  void rollDiceHandler() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Center(child: DiceRoller()));
  }
}
