import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {

  final void Function() presentDatePicker;
  final DateTime? selectedDate;
  final DateFormat formatter;

  const DateWidget({
    super.key,
    required this.presentDatePicker,
    required this.selectedDate,
    required this.formatter,
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      //horizontal placement
      mainAxisAlignment: MainAxisAlignment.end,
      //vertical placement
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedDate == null ?
              'No date selected' :
              formatter.format(selectedDate!) // ! -> this variable will never be null
              //so flutter is forced to execute a possibly null value (but the value is already checked
              //through the ternary expression)
          ),
          IconButton(
            onPressed: presentDatePicker,
            icon: const Icon(Icons.calendar_month),
          )
        ],
    );
  }
}