import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/cubit/counter_cubit.dart';
import 'package:quizz_app/screens/quiz.dart';
import 'providers/quizz_provider.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/quizz_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/counter_cubit.dart';

Future<void> main() async {
  /*runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>Counter())
        ],
        child: MyApp()
    )
  );*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          primarySwatch: Colors.red,
        ),
        home: const Quiz(),
      ),
    );
  }
}
