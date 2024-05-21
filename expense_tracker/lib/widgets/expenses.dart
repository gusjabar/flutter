import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 23.98,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: "Publix",
        amount: 129.99,
        category: Category.food,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The expenses chart'),
          Expanded(
            child: SizedBox(
              height: 400,
              child: ExpensesList(expenseList: _registeredExpenses),
            ),
          )
        ],
      ),
    );
  }
}
