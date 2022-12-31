import 'package:flutter/material.dart';

class QuestionView extends StatelessWidget {
  final Question question;
  final Function answerQuestion;

  QuestionView(this.question, this.answerQuestion);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 230,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage('assets/images/geography.jpg'),
                  fit: BoxFit.fill,
                  scale: 0.6),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.all(50),
              color: Colors.redAccent[100],
              height: 230,
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  question.questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  answerQuestion(question, true);
                },
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  answerQuestion(question, false);
                },
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Question {
  String questionText;
  bool isCorrect;

  Question({required this.questionText, required this.isCorrect});
}
