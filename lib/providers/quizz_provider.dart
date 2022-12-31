import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _score = 0;
  int _question_index = 0;

  int get score => _score;
  int get question_index => _question_index;

  void incrementScore(){
    _score++;
    notifyListeners();
  }
  void incrementIndex(){
    _question_index++;
    notifyListeners();
  }

}