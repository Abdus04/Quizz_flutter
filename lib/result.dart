import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  Result(this.score);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.all(50),
              color: Colors.redAccent[100],
              height: 230,
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Thanks for taking the quizz!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.all(50),
              color: Colors.redAccent[100],
              height: 230,
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Your final Score is $score',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              )),
        ],
      ),
    );
  }
}
