import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset(
              "assets/images/quiz-logo.png",
              width: 300,
              color: const Color.fromARGB(44, 243, 242, 242),
            ),
          ),
          const Text(
            "Learn Flutter",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton.icon(
              onPressed: startQuiz,
              icon: const Icon(Icons.arrow_right),
              label: const Text("Start Quiz"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 248, 246, 246),
                  backgroundColor: const Color.fromARGB(255, 68, 1, 70)),
            ),
          )
        ],
      ),
    );
  }
}
