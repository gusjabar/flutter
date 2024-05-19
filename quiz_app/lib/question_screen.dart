import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionScreen();
  }
}

class _QuestionScreen extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      //alternative to center content
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                currentQuestion.text,
                style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 222, 177, 240),
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            ),
            ...currentQuestion.getShuffledAnswers().map(
              (item) {
                return AnswerButton(answerText: item, onTap: answerQuestion);
              },
            ),
          ],
        ),
      ),
    );
  }
}
