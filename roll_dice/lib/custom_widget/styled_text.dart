import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.myText, {super.key});

  final String myText;

  @override
  Widget build(BuildContext context) {
    return Text(myText,
        style: const TextStyle(color: Colors.white, fontSize: 28));
  }
}
