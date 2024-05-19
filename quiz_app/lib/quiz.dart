import 'package:flutter/material.dart';
import 'package:quiz_app/question_screen.dart';

import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = const QuestionScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    //alternative way to change the screen.
    // Widget screenWidget = StartScreen(switchScreen);
    // if (activeScreen == 'questions-screen') {
    //   screenWidget = const QuestionScreen();
    // }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: (LinearGradient(colors: [
                Color.fromRGBO(103, 2, 110, 1),
                Color.fromRGBO(217, 81, 227, 1)
              ])),
            ),
            child: activeScreen),
      ),
    );
  }
}
