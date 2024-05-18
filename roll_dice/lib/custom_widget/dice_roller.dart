import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

//Manage StatefulWidget required to create to class DiceRoller and _DiceRollerState
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

//_DiceRollerState is a private class only available in this file
class _DiceRollerState extends State<DiceRoller> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/images/dice-$currentDiceRoll.png", width: 200),
        TextButton(
            onPressed: rollDiceHandler,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.only(top: 20)),
            child: const Text(
              "Roll Dice",
              style: TextStyle(fontSize: 28),
            ))
      ],
    );
  }

  var currentDiceRoll = randomizer.nextInt(6) + 1;
  void rollDiceHandler() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }
}
