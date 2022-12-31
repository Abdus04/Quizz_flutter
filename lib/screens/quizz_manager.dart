import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/cubit/counter_cubit.dart';
import 'package:quizz_app/providers/quizz_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'question.dart';
import 'result.dart';

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
    BlocProvider.of<CounterCubit>(context).incrementQuestionIndex();
    if (question.isCorrect == answer) {
      BlocProvider.of<CounterCubit>(context).incrementScore();
    }

    /*context.read<Counter>().incrementIndex();
    if (question.isCorrect == answer) {
      context.read<Counter>().incrementScore();
    }*/
    /*setState(() {
      questionNum += 1;

      if (question.isCorrect == answer) {
        score += 1;
      }
    });*/
  }

  Widget questionView(questionId) {
    if (questionId == questions.length) {
      //return Result(score);
      return Result(0);
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
      body: Column(
          children: [
            BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return questionView(state.questionIndex);
                }
            )
          ]),
    );
  }
}
