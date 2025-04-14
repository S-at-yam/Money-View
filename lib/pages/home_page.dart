import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:money_view/provider/profile_provider.dart';
import 'package:provider/provider.dart';

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
    final recentExpenses = expenseProvider.expenses.take(7).toList();
    final profile = context.watch<ProfileProvider>().profile;

    double expectedBudget =
        (expenseProvider.getTotalExpenseForCurrentMonth() /
            DateTime.now().day) *
        expenseProvider.getDaysInMonth(
          DateTime.now().year,
          DateTime.now().month,
        );

    if (profile == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Kindly add your profile first.',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      );
    }
    double spentPercent =
        expenseProvider.getTotalExpenseForCurrentMonth() / profile.target;

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
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width * 0.95,
                //color: kColorScheme.onPrimaryFixedVariant.withAlpha(70),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(230, 53, 40, 90),
                      const Color.fromARGB(255, 2, 8, 70),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(4, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white54,
                      offset: Offset(-4, -4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.084,
                            width: MediaQuery.of(context).size.width * 0.48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 72, 121, 122),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Budget',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      233,
                                      138,
                                      114,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  profile.target.toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.084,
                            width: MediaQuery.of(context).size.width * 0.48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 72, 121, 122),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Total Spent',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      233,
                                      138,
                                      114,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  expenseProvider
                                      .getTotalExpenseForCurrentMonth()
                                      .toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.084,
                            width: MediaQuery.of(context).size.width * 0.48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 72, 121, 122),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Expected Expenditure',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      233,
                                      138,
                                      114,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  expectedBudget.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        profile.target > expectedBudget
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            child: CircularProgressIndicator(
                              value: spentPercent,
                              backgroundColor: Colors.white,
                              strokeWidth: 16,
                              color:
                                  spentPercent > 0.8
                                      ? const Color.fromARGB(255, 114, 3, 3)
                                      : const Color.fromARGB(255, 1, 82, 4),
                            ),
                          ),
                          Text(
                            '${(spentPercent * 100).toStringAsFixed(0)} %',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 47, 12, 68),
                      const Color.fromARGB(255, 226, 33, 233),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(4, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white54,
                      offset: Offset(-4, -4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                // color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 4, 2, 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recent Expenses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 252, 251, 253),
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
