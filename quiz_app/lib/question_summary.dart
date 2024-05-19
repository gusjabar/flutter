import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  Color getTextColor(Map<String, Object> data) {
    return data["user_answer"] == data["correct_answer"]
        ? Colors.green
        : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: getTextColor(data),
                  child: Text(((data["question_index"] as int) + 1).toString()),
                ),
                Expanded(
                  //restrict the width of the Column to the width of the Row
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, bottom: 8, right: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["question"] as String,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data["user_answer"] as String,
                          style: TextStyle(color: getTextColor(data)),
                        ),
                        Text(data["correct_answer"] as String,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 168, 163, 235))),
                      ],
                    ),
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
