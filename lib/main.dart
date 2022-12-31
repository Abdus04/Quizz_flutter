import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';

import './quizz_manager.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled: true;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizzPage(title: 'Flutter Demo Home Page'),
    );
  }
}
