// runApp(); >> showing the user interface

import 'package:flutter/material.dart';
import 'package:roll_dice_demo/gradient_container.dart';

//gets executed automatically on a device
//>> do not need to call main() manually
void main() {
  //const >> reuse values that are equal and shows the same
  //memory log
  runApp(
    MaterialApp(
      home: Scaffold(
        body: const GradientContainer(colors: const [Color.fromARGB(255, 28, 0, 77),
               Color.fromARGB(255, 53, 15, 118)
               ]),
      ),
    ),
  );
  //>> main widget for setting up the app
  //Scaffold = Implements the basic Material Design visual layout structure.
}



//Flutter UIs are built with widgets >> widget tree

// ? >> Null safety >> the value can be null

//optional + required parameters (specified without [])
// >> default value is not supported with required 

//Both are optional parameters >> Dart optional 
//parameters are parameters that are not required 
//when calling a function. + default value is supported
// {} >> named parameters
// [] >> positional parameters

//Dart types: int, double, num (int + double), String, 
//bool, Object (any kind of object = all types)
//Dart is a type-safe language
//More than one type per object is common
//All values are of certain types

//All values + Widgets are Objects 
//>> Data structures in the memory

//Generic type: are flexible types that work together
//with other types (e.g.: Lists)







