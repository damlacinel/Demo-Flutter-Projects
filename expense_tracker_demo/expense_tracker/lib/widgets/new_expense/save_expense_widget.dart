import 'package:flutter/material.dart';

class SaveExpenseWidget extends StatelessWidget{

  final void Function() submitExpenseData;

  const SaveExpenseWidget({super.key, required this.submitExpenseData});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: submitExpenseData,
                    child: const Text('Save Expense'),
                  ),

                  TextButton(
                    onPressed: (){
                    //pop method removes the overlay from the screen
                    Navigator.pop(context);
                  }, 
                    child: const Text('Cancel'),
                  ),
                  
                  const Spacer(),
                ],
              ),
            )
          ]
    );
  }
}