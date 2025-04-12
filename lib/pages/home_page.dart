import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:money_view/main.dart';
import 'package:money_view/pages/add_new.dart';
import 'package:money_view/widgets/custom_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _loadExpensesFuture;

  @override
  void initState() {
    super.initState();
    _loadExpensesFuture =
        Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final recentExpenses = expenseProvider.expenses.reversed.take(7).toList();

    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.home),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => const AddNew()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.97,
                color: kColorScheme.primary.withAlpha(70),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text(
                        'Your Target : 6000',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'You have spent : 3000',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your expected Expense : 6500',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.535,
                width: MediaQuery.of(context).size.width * 0.97,
                color: kColorScheme.secondary,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 2, 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recent Expenses',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Expanded(
                      child: FutureBuilder(
                        future: _loadExpensesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (recentExpenses.isEmpty) {
                            return const Center(
                              child: Text('No recent expenses.'),
                            );
                          }

                          return ListView.builder(
                            itemCount: recentExpenses.length,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                expense: recentExpenses[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
