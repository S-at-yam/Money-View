import 'package:flutter/material.dart';
import 'package:money_view/models/expense.dart';
import 'package:money_view/pages/update_expense.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => UpdateExpense(expense: expense),
                ),
              );

              if (updated == true) {
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 5, 0, 27),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 20, 19, 19),
                offset: const Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Color.fromARGB(255, 77, 1, 1),
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailTile("Title", expense.title),
              detailTile("Amount", '₹${expense.amount.toStringAsFixed(2)}'),
              detailTile("Date", '${expense.date.toLocal()}'.split(' ')[0]),
              detailTile("Category", expense.category.name.toUpperCase()),
              if (expense.description != null &&
                  expense.description!.isNotEmpty)
                detailTile("Description", expense.description!),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
