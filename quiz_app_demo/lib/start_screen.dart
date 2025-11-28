import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget{

  final void Function() startQuiz;

  const StartScreen(this.startQuiz,{super.key});

  @override
  Widget build(BuildContext context) {
  return Center(
  // Center places its child in the middle of the available space.
  child: Column(
    // By default, Column takes the maximum height of the screen
    // (mainAxisSize: MainAxisSize.max). In that case, its content
    // starts at the top of the column, which visually appears at the
    // top of the screen even though the Column itself is centered.

    // Using MainAxisSize.min makes the Column only as tall as its children.
    // Because the Column becomes a small box, Center can place that box
    // exactly in the middle of the screen. As a result, the content
    // visually appears centered on the screen.
    mainAxisSize: MainAxisSize.min,

    children: [
      Image.asset(
        'assets/images/quiz-logo.png',
        width: 300,
        color: const Color.fromARGB(150, 255, 255, 255), 
        //transparency added without Opacity wrapper
      ),

       const SizedBox(height: 100), //padding

      Text(
                'Learn Flutter the fun way!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 185, 105, 239),
                ),
                ),

      const SizedBox(height: 50), //padding

      OutlinedButton.icon( //no background color
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                  ),
            foregroundColor: Colors.white, //text color
                ),
        onPressed: (){
          startQuiz();
        }, 
        icon: Icon(
          Icons.arrow_right_alt
        ),
        label: const Text( //child == label (because of 'icon' argument)
              'Start Quiz'
            )
      )
    ],
  ),
);
  }
}