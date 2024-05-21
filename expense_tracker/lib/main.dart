import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorSchema = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 72, 6, 117),
);

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(
      colorScheme: kColorSchema,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchema.onPrimaryContainer,
          foregroundColor: kColorSchema.primaryContainer),
      cardTheme: const CardTheme().copyWith(
        color: kColorSchema.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchema.primaryContainer),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.w500,
                color: kColorSchema.onSecondaryContainer,
                fontSize: 16),
          ),
    ),
    home: const Expenses(),
  ));
}
