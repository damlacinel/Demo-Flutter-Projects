import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget{
  final void Function(String answer) onSelectedAnswer;

  const QuestionsScreen(this.onSelectedAnswer, {super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

// _ ==> private
class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  
  void answerQuestion(String selectedAnswer) {
    //widget is defined in State-classes
    //gives access to the upper widget class and its properties
    //here: to selectOnAnswer
    widget.onSelectedAnswer(selectedAnswer);
    //setState >> build function should be executed again
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    //alternative approach to Center(Column(mainAxisSize: mainAxisSize.min))
    return SizedBox(
      width: double.infinity, //to take the entire width of the screen
      child: Container(
        margin: const EdgeInsets.all(40), 
        //to add padding >> because of .stretch
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //vertical axis
          crossAxisAlignment: CrossAxisAlignment.stretch, //horizontal axis 
          //stretch -> items in the Column will fulfill the screen length
          children: [
          Text(
            currentQuestion.text, 
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 169, 134, 245),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            ),
        
        const SizedBox(height: 30),
        
        // ... >> for spreading
        //is used to "spread" the elements of an iterable 
        //(such as a list or set) into another collection or 
        //as arguments to a function

        ...currentQuestion.getShuffledAnswers().map((answer) {
          //map does not change the existing list
          //it creates a new iterable
          return AnswerButton(
            answerText: answer,
            onTap: () { 
              //onTap needs a function without an argument
              answerQuestion(answer);
            },
          );
        })
        
        /* AnswerButton(
            answerText: currentQuestion.answers[0],
            onTap: () {}
            ),
            AnswerButton(
            answerText: currentQuestion.answers[1],
            onTap: () {}
            ),
            AnswerButton(
            answerText: currentQuestion.answers[2],
            onTap: () {}
            ),
            AnswerButton(
            answerText: currentQuestion.answers[3],
            onTap: () {}
            ), */
        ],
        ),
      ),
    );
  }

}