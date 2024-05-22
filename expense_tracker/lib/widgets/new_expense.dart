import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //to use native iOS look and feel controls

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

//future is a async/await function.
  void _presenterDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    //show dialog more looking as native app.
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Validation Result'),
          content: const Text('Invalid input'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.isEmpty ||
        amountIsInvalid ||
        _selectedCategory == null ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          category: _selectedCategory!,
          date: _selectedDate!),
    );
    //display the popup fill out all the screen.
    Navigator.pop(context);
  }

  Widget getTitleWidget() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Title'),
        ),
        SizedBox(
          width: 400,
          child: TextField(
            controller: _titleController,
            maxLength: 100,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getAmountWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Amount'),
        SizedBox(
          width: 150,
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: '\$',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getDateTimeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('Selected Date'),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? 'No Date Selected'
                  : formatter.format(_selectedDate!),
            ),
            IconButton(
              onPressed: () => _presenterDatePicker(),
              icon: const Icon(Icons.calendar_month),
            ),
          ],
        ),
      ],
    );
  }

  Widget getCategoryWidget() {
    return Column(
      children: [
        const Text('Selected Categroy'),
        DropdownButton(
            value: _selectedCategory,
            items: Category.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(categoriesIcon[e]),
                        const SizedBox(width: 8),
                        Text(e.name.toUpperCase())
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedCategory = value;
              });
            })
      ],
    );
  }

  Widget getCommnadsButtonWidget() {
    return Row(
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: () => _submitExpenseData(),
          icon: const Icon(
            Icons.save,
            size: 24.0,
          ),
          label: const Text('Save'),
        )
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; //avoid keyword overlaping with user controls.

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth; //availabel width
      //care about the parent widget

      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 45, 15, 15 + keyboardSpace),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title
                      getTitleWidget(),
                      const Spacer(),
                      //Amount
                      getAmountWidget(),
                    ],
                  )
                else
                  //Title
                  getTitleWidget(),
                Row(
                  children: [
                    if (width < 600)
                      //Amount
                      getAmountWidget(),
                    if (width >= 600)
                      //Category list
                      getCategoryWidget(),
                    const Spacer(),
                    //Date
                    getDateTimeWidget(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (width < 600)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Category list
                          getCategoryWidget(),
                        ],
                      ),
                    const Spacer(),
                    //Buttons
                    getCommnadsButtonWidget(),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
