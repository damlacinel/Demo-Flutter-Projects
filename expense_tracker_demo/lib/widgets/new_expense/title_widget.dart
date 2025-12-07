import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget{

  final TextEditingController titleController;

  const TitleWidget({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return TextField(
       //for multiple text fields, we need multiple controllers
        controller: titleController,
       //maximum amount of characters that can be entered
        maxLength: 50,
      //decoration is for label
        decoration: const InputDecoration(
          label: Text('Title'),
        )
       //default version
      //keyboardType: TextInputType.text,
    );
  }
}