import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:money_view/widgets/chart_widget.dart';
import 'package:money_view/widgets/daily_bar_chart.dart';

import 'package:provider/provider.dart';

class DailyBarChartPage extends StatefulWidget {
  const DailyBarChartPage({super.key});

  @override
  State<DailyBarChartPage> createState() => _DailyBarChartPageState();
}

class _DailyBarChartPageState extends State<DailyBarChartPage> {
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();

    _fetchData =
        Provider.of<ExpenseProvider>(context, listen: false).barChartData();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ExpenseProvider>(context);
    return FutureBuilder(
      future: _fetchData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (dataProvider.expenses.isEmpty) {
          return const Center(child: Text('No expenses yet.'));
        }
        int daysOfMonth = dataProvider.getDaysInMonth(
          DateTime.now().year,
          DateTime.now().month,
        );

        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.79,
            width: MediaQuery.of(context).size.width * 0.99,

            child: ChartPage(
              title: 'Daily Expenses',
              chart: DailyBarChart(
                dailyData: dataProvider.data,
                daysOfMonth: daysOfMonth,
              ),
            ),
          ),
        );
      },
    );
  }
}
