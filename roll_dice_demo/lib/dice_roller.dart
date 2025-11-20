import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

//always 2 classes with StatefulWidget
class DiceRoller extends StatefulWidget {

  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }

}

// _ >> private class
class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice(){

    //to update UI
    //this case: re-execute build function
    setState(() {
      //performance fixer == instead Random() >> randomizer object
      // random doesn't created over and over + thrown out
      //when not needed anymore
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(Object context) {
    return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/dice-$currentDiceRoll.png', 
                  width: 200),

                  const SizedBox(height:20), //padding

                  TextButton(
                  onPressed: rollDice,
                  style: TextButton.styleFrom(
                    //padding: EdgeInsets.only(top:20),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 28),
                    ),
                  child:const Text('Roll Dice'),
                  )
              ],
            );
  }

}