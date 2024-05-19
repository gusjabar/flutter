import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionScreen();
  }
}

class _QuestionScreen extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //alternative to center content
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Question 1",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
          AnswerButton(answerText: "Answer 1", onTap: () {}),
          AnswerButton(answerText: "Answer 2", onTap: () {}),
          AnswerButton(answerText: "Answer 3", onTap: () {}),
          AnswerButton(answerText: "Answer 4", onTap: () {}),
        ],
      ),
    );
  }
}
