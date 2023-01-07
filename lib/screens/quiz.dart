import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/screens/quiz_create.dart';
import 'package:quizz_app/screens/quizz_manager.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> _themes = <String>["geography", "history", "math"];
  var _SelectedTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        drawer: Drawer(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.redAccent,
                centerTitle: true,
                title: Text("Menu"),
              ),
              ListTile(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              QuizCreatePage(
                              )));
                },
                title: Text(
                  "Manage Quiz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Quizz page'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: initialQuizView() //themeQuizView('geography')
        );
  }

  Widget initialQuizView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.all(50),
              height: 230,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent[100],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to this simple Quiz Application',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              )),
          SizedBox(
            width: 50,
          ),
          StreamBuilder(
              stream: readThemes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _themes = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color(0xfff9f1f0),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(12),
                        child: DropdownButton(
                          items: _themes
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selectedTheme) {
                            setState(() {
                              _SelectedTheme = selectedTheme;
                            });
                          },
                          value: _SelectedTheme,
                          hint: Text(
                            'Select the quizz theme!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          isExpanded: true,
                          isDense: false,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextButton(
                        onPressed: () {
                          print(_SelectedTheme);
                          if (_SelectedTheme != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        QuizzPage(
                                          theme: _SelectedTheme,
                                        )));
                          }
                        },
                        child: Text("Choose Theme",
                            style: TextStyle(color: Colors.white)),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            fixedSize: Size(120, 32)),
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }

  Stream<List<String>> readThemes() => FirebaseFirestore.instance
      .collection('themes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => doc.get("name").toString()).toList());
}
