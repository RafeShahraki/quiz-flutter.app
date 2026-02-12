import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<String> questnions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.',
  // ];
  // List<bool> answers = [false, true, true];
  void alert() {
    Alert(
      context: context,
      title: "Finished!",
      desc: "You've reached the end of quiz.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            quizBrain.ender();
          },
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.geQuestionsText(quizBrain.pointer),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Card(
              color: Colors.green,
              child: TextButton(
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  //The user picked true.
                  bool correctAnwer = quizBrain.getQuestionsAnswer(
                    quizBrain.pointer,
                  );
                  if (correctAnwer == true) {
                    quizBrain.correct();
                  } else {
                    quizBrain.inccorect();
                  }
                  setState(() {
                    if (quizBrain.checkEnd() == true) {
                      alert();
                    }
                    quizBrain.nextQuestion();
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Card(
              color: Colors.red,
              child: TextButton(
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  bool correctAnwer = quizBrain.getQuestionsAnswer(
                    quizBrain.pointer,
                  );
                  if (correctAnwer == false) {
                    quizBrain.correct();
                  } else {
                    quizBrain.inccorect();
                  }
                  setState(() {
                    if (quizBrain.checkEnd() == true) {
                      alert();
                    }
                    quizBrain.nextQuestion();
                  });
                },
              ),
            ),
          ),
        ),
        Row(children: quizBrain.scoreKeeper),
      ],
    );
  }
}
