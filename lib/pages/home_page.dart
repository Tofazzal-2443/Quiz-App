import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/custom_widget/quiz_item.dart';
import 'package:quiz_app/db/temp_db.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String genderGroupValue = 'Male';
  Timer? timer;
  int count = 20;
  bool hasQuizStarted = false;

  @override
  void initState() {
    quizList = generateQuizList;
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        setState(() {
          count--;
        });
      } else {
        stopTimer();
        navigateToResult();
      }
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Time Remains: $count sec'),
          actions: [
            if(hasQuizStarted) TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                stopTimer();
                navigateToResult();
              },
              child: const Text('Finish'),
            ),
            if(!hasQuizStarted) TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  hasQuizStarted = true;
                });
                startTimer();
              },
              child: const Text('Start'),
            )
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                final quiz = quizList[index];
                return QuizItem(
                  serial: index + 1,
                  quiz: quiz,
                  onAnswer: (answer) {
                    quizList[index].givenAnswer = answer;
                  },
                );
              },
            ),
            if(!hasQuizStarted) Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text('Click Start button to start the Quiz'),

            ),
          ],
        ));
  }

  void navigateToResult() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultPage()));
  }
}
