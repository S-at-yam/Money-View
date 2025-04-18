import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:provider/provider.dart';

import 'package:money_view/widgets/custom_list_tile.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<void> _fetchExpensesFuture;

  @override
  void initState() {
    super.initState();

    _fetchExpensesFuture =
        Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('History')),
      backgroundColor: const Color.fromARGB(255, 105, 171, 224),
      body: FutureBuilder(
        future: _fetchExpensesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (expenseProvider.expenses.isEmpty) {
            return const Center(child: Text('No expenses yet.'));
          }

          return ListView.builder(
            itemCount: expenseProvider.expenses.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 8, 2),
                child: CustomListTile(
                  expense: expenseProvider.expenses[index],
                  listColor: const Color.fromARGB(255, 16, 4, 73),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
