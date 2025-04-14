import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:money_view/widgets/chart_widget.dart';
import 'package:money_view/widgets/pie_chart.dart';
import 'package:provider/provider.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  late Future<void> _fetchData;
  @override
  void initState() {
    super.initState();

    _fetchData =
        Provider.of<ExpenseProvider>(context, listen: false).pieChartData();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ExpenseProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      backgroundColor: const Color.fromARGB(155, 91, 176, 245),
      body: FutureBuilder(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (dataProvider.expenses.isEmpty) {
            return const Center(child: Text('No expenses yet.'));
          }

          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.79,
              width: MediaQuery.of(context).size.width * 0.99,

              child: PageView(
                children: [
                  ChartPage(
                    title: 'Expense by Category',
                    chart: ExpensePieChart(data: dataProvider.data),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
