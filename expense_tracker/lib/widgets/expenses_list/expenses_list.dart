import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenseList, required this.onRemoveExpense});

  final void Function(Expense) onRemoveExpense;
  final List<Expense> expenseList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenseList[index]),
        onDismissed: (direction) => onRemoveExpense(expenseList[index]),
        child: ExpenseItem(
          expense: expenseList[index],
        ),
      ),
    );
  }
}
