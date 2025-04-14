import 'package:flutter/material.dart';
import 'package:money_view/data/db_helper.dart';
import 'package:money_view/models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];
  List<Map<String, dynamic>> _data = [];
  final DBHelper _dbHelper = DBHelper();

  List<Expense> get expenses => _expenses;
  List<Map<String, dynamic>> get data => _data;

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

  Future<bool> deleteExpenseById(String id) async {
    final removedRows = await _dbHelper.deleteExpense(id);

    if (removedRows > 0) {
      _expenses.removeWhere((expense) => expense.id == id);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    await _dbHelper.updateExpense(updatedExpense);

    final index = _expenses.indexWhere((e) => e.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  Future<void> pieChartData() async {
    final chartData = await _dbHelper.getCategoryExpenses();
    _data.clear();
    _data.addAll(chartData);
    notifyListeners();
  }
}
