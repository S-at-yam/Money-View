import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_view/models/expense.dart';
import 'package:money_view/pages/expense_detail_page.dart';

import 'package:provider/provider.dart';
import 'package:money_view/provider/expense_provider.dart';

class CustomListTile extends StatelessWidget {
  final Expense expense;
  final Color? listColor;

  const CustomListTile({super.key, this.listColor, required this.expense});

  @override
  Widget build(BuildContext context) {
    final expenseId = expense.id;
    if (expenseId == null || expenseId.isEmpty) {
      log('expense id is not passed');
    }
    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) async {
        final provider = Provider.of<ExpenseProvider>(context, listen: false);
        final deletedExpense = expense; // Keep a copy of the deleted expense

        // Delete from DB and provider
        if (expenseId == null || expenseId.isEmpty) {
          log('error in deleting');
        } else {
          log(expenseId);
          try {
            bool deleted = await provider.deleteExpenseById(expenseId);
            if (deleted) {
              log('success');
            } else {
              log('failed');
            }
          } catch (err) {
            print('error');
          }
        }

        // Show SnackBar with Undo option
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Expense deleted"),
            action: SnackBarAction(
              label: "UNDO",
              onPressed: () async {
                // Re-add the expense if undo is pressed
                await provider.addExpense(deletedExpense);
              },
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      child: ListTile(
        tileColor: listColor,
        onTap: () async {
          final updated = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ExpenseDetailPage(expense: expense),
            ),
          );

          if (updated == true) {
            // Trigger UI update by refetching expenses if needed
            Provider.of<ExpenseProvider>(
              context,
              listen: false,
            ).fetchExpenses();
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              expense.dateDay,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 167, 38),
                fontSize: 18,
              ),
            ),
            Text(
              expense.dateMonth,
              style: const TextStyle(
                color: Color.fromARGB(255, 248, 186, 127),
                fontSize: 15,
              ),
            ),
          ],
        ),
        title: Text(
          expense.title[0].toUpperCase() +
              expense.title.substring(1).toLowerCase(),
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        trailing: Text(
          '₹${expense.amount.toStringAsFixed(2)}', // Display amount with 2 decimals
          style: const TextStyle(
            color: Color.fromARGB(255, 237, 240, 237),
            fontSize: 20,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              categoryIcons[expense.category],
              color: const Color.fromARGB(255, 115, 193, 230),
            ),
          ],
        ),
      ),
    );
  }
}
