import 'package:flutter/material.dart';
import 'package:quiz_app/db/temp_db.dart';
import 'package:quiz_app/pages/custom_style.dart';
import 'package:quiz_app/pages/home_page.dart';


class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = getResult;
    return Scaffold(
      appBar: AppBar(title: const Text('Result'),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Correct: ${result.correct}', style: resultStyle,),
            Text('Incorrect: ${result.incorrect}', style: resultStyle,),
            TextButton(
              onPressed: () {
                quizList = [];
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text('Start Over'),
            )
          ],
        ),
      ),
    );
  }
}
