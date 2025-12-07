import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {

  final TextEditingController expenseController;

  const AmountWidget({super.key, required this.expenseController});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: expenseController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
        ),
    );
  }
}