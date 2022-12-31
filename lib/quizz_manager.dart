import 'package:flutter/material.dart';

import './question.dart';
import './result.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<String> characters = ["Zhongli", "Kamisato Ayato", "Kuki Shinobu"];
  List<Question> questions = [
    Question(
        questionText: "Canada is the 2nd Largest country in the world",
        isCorrect: true),
    Question(
        questionText: "Nile is the widest river in the world",
        isCorrect: false),
    Question(
        questionText: "Nigeria is the most populated country in africa",
        isCorrect: true),
    Question(questionText: "France has 12 time zones", isCorrect: true)
  ];
  int questionNum = 0;
  int score = 0;

  void _answerQuestion(Question question, bool answer) {
    setState(() {
      questionNum += 1;

      if (question.isCorrect == answer) {
        score += 1;
      }
    });
  }

  Widget questionView(questionId) {
    if (questionId == questions.length) {
      return Result(score);
    } else {
      Question question = questions.elementAt(questionId);
      return QuestionView(question, _answerQuestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Quizz page'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(children: [questionView(questionNum)]),
    );
  }
}
