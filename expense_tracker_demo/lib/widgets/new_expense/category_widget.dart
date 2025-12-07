import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class CategoryWidget extends StatefulWidget {
  final Category selectedCategory;
  const CategoryWidget({super.key, required this.selectedCategory});
  
  @override
  State<CategoryWidget> createState() {
    return _CategoryWidgetState();
  }
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Category _currentCategory = Category.leisure;

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
          value: _currentCategory,
          items: Category.values
            .map(
                (category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()
                ),
              )
            )
            .toList(), 
              onChanged: (value) {
                if(value == null) return;
                    setState(() { 
                      _currentCategory = value;
                    });
                  },
      );
  }
}