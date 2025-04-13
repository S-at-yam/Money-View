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

  double getTotalExpenseForCurrentMonth() {
    final now = DateTime.now();
    final currentMonthExpenses = _expenses.where(
      (expense) =>
          expense.date.month == now.month && expense.date.year == now.year,
    );

    return currentMonthExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  int getDaysInMonth(int year, int month) {
    // If month is December, next month is January of next year
    if (month == 12) {
      year += 1;
      month = 1;
    } else {
      month += 1;
    }

    // Subtract one day from the first day of the next month
    final lastDayOfMonth = DateTime(
      year,
      month,
      1,
    ).subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  Future<void> deleteExpenseById(String id) async {
    await _dbHelper.deleteExpense(id);
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  // Add update/delete here if needed later
}
