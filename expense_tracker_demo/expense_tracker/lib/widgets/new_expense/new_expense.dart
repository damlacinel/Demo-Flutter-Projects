import 'package:expense_tracker/widgets/new_expense/amount_widget.dart';
import 'package:expense_tracker/widgets/new_expense/category_widget.dart';
import 'package:expense_tracker/widgets/new_expense/date_widget.dart';
import 'package:expense_tracker/widgets/new_expense/save_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart'; //ios design language
import 'package:expense_tracker/widgets/new_expense/title_widget.dart';

import 'dart:io'; //for Platform

/// The line `final formatter = DateFormat.yMd();` is creating an instance of the `DateFormat` class
/// from the `intl` package. This particular instance is formatting dates in the format `Month/Day/Year`
/// (e.g., 12/31/2022). The `formatter` variable can be used throughout the code to format dates
/// according to this pattern.
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget{

  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //for user input
  final _titleController = TextEditingController();
  final _expenseController = TextEditingController();

  DateTime? _selectedDate;
  late Category _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

//async and await are only used with Future values
//with await you can store the future variables
    //returns data type => Future<DateTime?>
    //in the future some date will be picked using the date picker
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: now,
      );
      //this line will be executed when the value is available

      setState(() {
        _selectedDate = pickedDate;
      });
  }

//How to build adaptive apps? 
  void _showDialog() {
    if(Platform.isAndroid) {
    showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              }, 
              child: const Text('Okay'),
              ),
            ],
          ) ,
        );
    } else {
      showCupertinoDialog(context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              }, 
              child: const Text('Okay'),
              ),
            ],
          )
        );
    }

  }

  void _submitExpenseData() {
    final enteredExpense = double.tryParse(_expenseController.text);
    final expenseIsInvalid = enteredExpense == null || enteredExpense <= 0;
    if (_titleController.text.trim().isEmpty || expenseIsInvalid || _selectedDate == null) {
      //show error message
      _showDialog();
      return; //no code after gets executed
    }
      widget.onAddExpense(
        Expense(
          title: _titleController.text, 
          amount: enteredExpense, 
          date: _selectedDate!, 
          category: _selectedCategory,
          )
      );

      Navigator.pop(context); //Overlay is closed after adding a new expense
  }

  //one must delete the controller after use >> memory use efficiency 
  //only 'state' classes can implement dispose method!!!
  @override
  void dispose() {
    _titleController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //UI elements that are overlapping other elements from the botton
    //(e.g. keyboard overlaps the other input entry areas)
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    
    return LayoutBuilder(
  builder: (ctx, constraints) {
    final width = constraints.maxWidth;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              // TITLE + AMOUNT (wide layout)
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleWidget(titleController: _titleController),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AmountWidget(expenseController: _expenseController),
                    ),
                  ],
                )
              else
                // TITLE only (narrow)
                TitleWidget(titleController: _titleController),

              const SizedBox(height: 16),

              // DATE + CATEGORY (wide layout)
              if (width >= 600)
                Row(
                  children: [
                    Expanded(
                      child: DateWidget(
                        presentDatePicker: _presentDatePicker,
                        selectedDate: _selectedDate,
                        formatter: formatter,
                      ),
                    ),
                    const SizedBox(width: 16),
                    CategoryWidget(selectedCategory: _selectedCategory),
                  ],
                )
              else
                // AMOUNT + DATE (narrow layout)
                Row(
                  children: [
                    Expanded(
                      child: AmountWidget(
                        expenseController: _expenseController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DateWidget(
                        presentDatePicker: _presentDatePicker,
                        selectedDate: _selectedDate,
                        formatter: formatter,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 16),

              // Bottom widget depending on width
              if (width >= 600)
                SaveExpenseWidget(submitExpenseData: _submitExpenseData)
              else
                CategoryWidget(selectedCategory: _selectedCategory),
            ],
          ),
        ),
      ),
    );
  },
);
}
}