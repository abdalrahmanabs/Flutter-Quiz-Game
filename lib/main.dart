import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quizzler/quiz_Manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

QuizManager quizmanager = QuizManager();

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void AddScore(bool buttonClicked) {
    bool answer =
        quizmanager.getQuestionAnswer() == buttonClicked ? true : false;
    final icon = Icon(answer ? Icons.check : Icons.close,
        color: answer ? Colors.green : Colors.red);

    if (answer)
      quizmanager.correctAnswers++;
    else
      quizmanager.wrongAnswers++;

    quizmanager.percentage = (quizmanager.correctAnswers /
            (quizmanager.correctAnswers + quizmanager.wrongAnswers)) *
        100;
    setState(() {
      if (!quizmanager.isFinsihed) {
        scoreKeeper.add(icon);
        quizmanager.nextQuestion();
      } else
        showFinishAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                quizmanager.getQuestionText(),
                style: TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: Text("صحيح",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              onPressed: () {
                AddScore(true);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                "غير صحيح",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                AddScore(false);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void showFinishAlert() {
    Alert(
      context: context,
      title: 'انتهت الأسئلة',
      desc: 'لقد قمت بالإجابة عن جميع الأسئلة',
      content: Column(
        children: [
          Text('إجاباتك الصحيحة : ${quizmanager.correctAnswers}'),
          Text('إجاباتك الخاطئة: ${quizmanager.wrongAnswers}'),
          Text('نسبة الإجابات الصحيحة : ${quizmanager.percentage.toStringAsFixed(0)}%'),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            'حسنًا',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.blue,
        ),
      ],
    ).show();
  }
}
