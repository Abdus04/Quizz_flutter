import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/cubit/counter_cubit.dart';
import 'package:quizz_app/providers/quizz_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'question.dart';
import 'result.dart';

class QuizzPage extends StatefulWidget {
  final String theme;

  const QuizzPage({Key? key, required this.theme}) : super(key: key);

  @override
  _QuizzPageState createState() => _QuizzPageState(theme);
}

class _QuizzPageState extends State<QuizzPage> {
  _QuizzPageState(this._SelectedTheme);

  List<String> characters = ["Zhongli", "Kamisato Ayato", "Kuki Shinobu"];
  List<Question> questions = [
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
  List<String> _themes = <String>["geography", "history", "math"];
  var _SelectedTheme;

  CollectionReference cr = FirebaseFirestore.instance.collection('geography');

  void _answerQuestion(Question question, bool answer) {
    //print(Fquestions.elementAt(0));
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
            automaticallyImplyLeading: false),
        body: themeQuizView(_SelectedTheme));
  }

  Widget themeQuizView(String theme) {
    return StreamBuilder(
        stream: readQuestions(theme),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            questions = snapshot.data!;
            return Column(children: [
              BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                return questionView(state.questionIndex);
              })
            ]);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Stream<List<Question>> readQuestions(String theme) => FirebaseFirestore
      .instance
      .collection("themes")
      .doc(theme)
      .collection("questions")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Question.fromJson(doc.data())).toList());
}
