import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;
  
  @override
  Widget build(BuildContext context) {
    //Card widget is used for styling purposes
    //>> gives an elevated look
    //automatically adds top + bottom margin -> padding
    // Card does not have padding argument >> refactor with padding
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, 
            //theme defined in the main.dart file gets applied here
                style: Theme.of(context).textTheme.titleLarge,
                ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  // $'' -> String interpolation
                  // whenever the expression is not a simple variable
                  // e.g. : a function call occurs or '.' is being used (for object properties)
                  '\$${expense.amount.toStringAsFixed(2)}',
                ), //20.3432 -> 20.34
                const Spacer(), //Spacer takes all the remaining space
                //text will be pushed to the left and Row to the right
                Row(
                  children: [
                    //categoryIcons[] -> Map, but the key is an Enum
                    //that's why we don't use categoryIcons['']
                    //if key was a String then we could use that annotation
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width:8),
                    //not formattedDate() -> because it is a getter
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ) 
      ),
    );
  }
}