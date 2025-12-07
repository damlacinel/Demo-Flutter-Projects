import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

//To output the chart and expenses list

class Expenses extends StatefulWidget {

  const Expenses({super.key}); 

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69, 
      date: DateTime.now(), 
      category: Category.leisure
      ),
  ];

  void _openAddExpenseOverlay() {
    //with show we can access the built-in UI elements
    showModalBottomSheet(
      //device features like camera etc. does not overlap
      useSafeArea: true,
      //context property available because this class is a State class
      //context = widget meta data + contains information on relation 
      //to other widget + its widget's position in overall widget tree
      //every widget has its own context data
      //here: context holds information about the Expenses widget and its position 
      context: context, 
      //ctx != context --> ctx is the context of the ModalBottomSheet
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      isScrollControlled: true, //Modal overlay takes all available height
      //so that keyboard + other additional elements doesn't overlap on input fields
      );
  }

  void _addExpense (Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense (Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

  //clear all existing info messages on the screen
  //so that any info message on the screen overlaps
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          ),
        )
      );
  }

//if a user rotates the device v-> build() method gets executed again
//so the height and width of the screen gets adjusted accordingly
  @override
  Widget build(BuildContext context) {
    //To figure out the available height and width on the screen
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if(_registeredExpenses.isNotEmpty) {
        mainContent = ExpensesList(
          expenses: _registeredExpenses, 
          onRemoveExpense: _removeExpense,
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            //not _openAddExpenseOverlay() -> because Flutter
            //executes the function right there
            //but our intension here is that the functions gets
            //executed when the user taps on the button
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          //ListView inside Column >> needed to be refactored with Expanded
          //otherwise the list would not be shown
          Expanded(
            child: mainContent,
          ),
        ],      
        ) : Row(
          children: [
            //Expanded -> Chart widget height is set to double.infinity
            //but Row also has that feature, so they cannot work together
            //to render the UI -> that's why we have to wrap Chart with Expanded
            //Here: Expanded constraints the child (Chart) to only
            //take as much width as available in the Row after sizing the other 
            //Row children
          Expanded(child: Chart(expenses: _registeredExpenses)),
          //ListView inside Column >> needed to be refactored with Expanded
          //otherwise the list would not be shown
          Expanded(
            child: mainContent,
          ),
          ],      
        )
    );
  }
}