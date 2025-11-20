import 'package:flutter/material.dart';
import 'package:roll_dice_demo/dice_roller.dart';

//you can reassign variables that are crated using 'var'
//const == compile time constant -- final can be used as well
// (but that doesn't improve the performance)
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {

  const GradientContainer({super.key, required this.colors});
  //GradientContainer({key}) : super(key:key); 

  final List<Color> colors;
  
 
  @override
  Widget build(context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
                begin: startAlignment,
                end: endAlignment,
           ),
          ),
          child: Center(
            //200 pixels >> smaller image
            child: DiceRoller(), 
           ),
        );
  } 

}

// (){} >> anonymous function