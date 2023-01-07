import 'package:flutter/material.dart';
import 'package:quizz_app/screens/quiz.dart';
import 'package:quizz_app/screens/quizz_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizCreatePage extends StatefulWidget {
  const QuizCreatePage({Key? key}) : super(key: key);

  @override
  _QuizCreatePageState createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  final themeNameController = TextEditingController();
  final questionContentController = TextEditingController();
  List<String> _themes = <String>["geography", "history", "math"];
  List<String> _answers = <String>["True", "False"];
  var _SelectedTheme;
  var _SelectedAnswer=null ;

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
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Quiz()));
                },
                title: Text(
                  "Take The Quiz",
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
          title: Text('Quiz Creation page'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //padding: EdgeInsets.all(16),
                children: [
                  Text("Add Theme",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: Colors.red),),
                  SizedBox(height: 10,)
                  ,TextField(
                    controller: themeNameController,
                    decoration: decoration('Enter the New Theme Name'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        createTheme(themeNameController.text);
                      },
                      child: Text('Add'))
                ],
              ),
              addQuestion()
            ],
          ),
        ) //themeQuizView('geography')
        );
  }

  InputDecoration decoration(String s) => InputDecoration(
        labelText: s,
        border: OutlineInputBorder(),
      );

  Future createTheme(String themeName) async {
    final docTheme =
        FirebaseFirestore.instance.collection("themes").doc(themeName);

    await docTheme.set({'name': themeName});
  }
  Future createQuestion(String theme, String content, bool answer) async {
    final docQuestion= FirebaseFirestore.instance.collection("themes").doc(theme).collection("questions").doc();

    await docQuestion.set({'content': content, 'answer': answer});
  }

  Widget addQuestion() {
    return StreamBuilder(
        stream: readThemes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _themes = snapshot.data!;
            return Column(
              children: [
                Text("Add Question",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: Colors.red),),
                SizedBox(height: 10,),
                Container(
                  height: 80,
                  width: double.infinity,
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
                        _SelectedTheme = selectedTheme!;
                      });
                    },
                    value: _SelectedTheme,
                    hint: Text(
                      'Select the question theme',
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
                TextField(
                  controller: questionContentController,
                  decoration: decoration('Enter the New Question'),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xfff9f1f0),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(12),
                  child: DropdownButton(
                    items: _answers
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (selectedAnswer) {
                      setState(() {
                        _SelectedAnswer=selectedAnswer;
                      });
                    },
                    value: _SelectedAnswer,
                    hint: Text(
                      'Select the Answer',
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
                    if(_SelectedAnswer=="True"){
                      createQuestion(_SelectedTheme, questionContentController.text, true);
                    } else if(_SelectedAnswer=="False"){
                      createQuestion(_SelectedTheme, questionContentController.text, false);
                    }

                  },
                  child: Text("Add Question",
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
        });
  }

  Stream<List<String>> readThemes() => FirebaseFirestore.instance
      .collection('themes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => doc.get("name").toString()).toList());
}
