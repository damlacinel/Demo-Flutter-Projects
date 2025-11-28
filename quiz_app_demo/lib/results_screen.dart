import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  final void Function() restartQuiz;

  const ResultsScreen({
    super.key, 
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  final List<String> chosenAnswers;

  //Object >> allows all kind of values , e.g. : int, String, double etc. 
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for(var i = 0; i < chosenAnswers.length; i++) {
      //{} -> to create a map value
      summary.add(
        {
        'question_index' : i,
        'question' : questions[i].text,
        'correct_answer' : questions[i].answers[0], //always first answer correct
        'user_answer' : chosenAnswers[i]
        }
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    //List filtering >> .where() >> does not change the list
    //returns a new list as iterable
    final numCorrectQuestions = summaryData.where((data){
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(151, 255, 255, 255),
                ),
              ),
            const SizedBox(height:30),
            QuestionsSummary(summaryData: summaryData),
            const SizedBox(height:30),
            OutlinedButton.icon( //no background color
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                  ),
            foregroundColor: Colors.white, //text color
                ),
        onPressed: (){
          restartQuiz();
        }, 
        icon: Icon(
          Icons.restart_alt
        ),
        label: const Text( //child == label (because of 'icon' argument)
              'Restart Quiz!'
            )
      )
          ],
        ),
      ),
    );
  }
}