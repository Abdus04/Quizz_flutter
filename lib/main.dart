import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/cubit/counter_cubit.dart';
import 'providers/quizz_provider.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/quizz_manager.dart';
import 'cubit/counter_cubit.dart';

void main() {
  /*runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>Counter())
        ],
        child: MyApp()
    )
  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context)=> CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const QuizzPage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
