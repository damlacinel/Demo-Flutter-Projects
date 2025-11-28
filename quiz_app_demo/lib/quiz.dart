import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget{

  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }

}

class _QuizState extends State<Quiz> {
/* First possible approach
/it is allowed to store Widgets in variables
Widget? currentScreen;

extra initialization when the state object is created for the first time
  @override
  void initState() {
  /We cannot assign `currentScreen = StartScreen(switchScreen)` directly at the
  /field declaration, because the State object has not been fully initialized yet.  
  /During field initialization, the State instance is not mounted, and callbacks
  /or widget-related references (such as `switchScreen`) are not guaranteed to be
  /ready or safe to use.

  /`initState()` is the correct place for this kind of initialization because it
  /is called once the State object has been created, mounted, and fully connected
  /to its associated Widget. At that point, all callbacks and properties are
  /available, so creating child widgets or performing UI-related setup is safe.
    currentScreen = StartScreen(switchScreen);
    super.initState();
}
*/

var currentScreen = 'start-screen';
List<String> selectedAnswers = [];

  void switchScreen(){
    setState(() {
      //var currentScreen issues warnings >> because var represents a general type
      //here the type should be restricted to avoid warnings
    currentScreen = 'questions-screen';
    //we can use const here even though it is a stateful widget
    // >> the constructor is defined by const
    });
  }

  /*
  We store `selectedAnswers` and handle `chooseAnswer()` inside the
  Quiz widget (the parent), not inside QuestionsScreen (the child),
  because the parent widget controls the overall flow of the app.

  QuestionsScreen is only responsible for displaying a single question
  and reporting which answer the user selected. It should NOT store the
  full list of answers, because this screen is temporary: every time the
  user moves forward, QuestionsScreen is rebuilt or replaced. Any state
  stored inside it would be lost.

  The Quiz widget, on the other hand, stays alive for the entire quiz.
  It manages:
    - which screen is currently shown (start, questions, results, ...)
    - the list of all selected answers
    - the overall navigation and quiz progress

  Therefore, QuestionsScreen notifies the parent by calling
  `onSelectedAnswer(answer)`. The parent (Quiz) then updates its own
  state by storing the answer in `selectedAnswers`.

  This follows the Flutter principle of "lifting state up":
  if a child widget's data affects the overall app flow, the state must
  be managed by the parent, while the child acts only as a UI component
  that sends events upward.
*/
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        currentScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);
    
    if (currentScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(chooseAnswer);
    }

    if (currentScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        restartQuiz: () {
          selectedAnswers = [];
          switchScreen();
        },
        );
    }

    return MaterialApp(
      home: Scaffold(
        //start screen custom widget
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 64, 8, 160),
                const Color.fromARGB(255, 86, 45, 158)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              )
          ),
          child: screenWidget
          ),
      ),
    );
  }

}