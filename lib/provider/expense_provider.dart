// lib/providers/expense_provider.dart
import 'package:flutter/material.dart';
import 'package:money_view/data/db_helper.dart';
import 'package:money_view/models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];
  final DBHelper _dbHelper = DBHelper();

  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    final data = await _dbHelper.getExpenses();
    _expenses.clear();
    _expenses.addAll(data);

    _expenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _dbHelper.insertExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  // Add update/delete here if needed later
}
