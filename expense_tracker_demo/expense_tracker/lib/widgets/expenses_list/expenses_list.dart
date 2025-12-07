import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';


class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //list of unknown length (e.g:100 or 2) >> Column is not ideal
    //ListView is by default scrollable
    //It's particularly useful when dealing with a large number 
    //of items because it creates items on-demand as the user 
    //scrolls, reducing memory usage and improving performance. 
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          //themes can be adjusted e.g.: .withBlue()
          //this does not change the overall scheme just does adjustments here
          color: Theme.of(context).colorScheme.error.withBlue(10),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          )
        ),
        onDismissed: (direction) { //direction is ignored
        //direction -> in which direction the user swiped
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index])
        ),
      itemCount: expenses.length,
      );
  }
}