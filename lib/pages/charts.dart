import 'package:flutter/material.dart';
import 'package:money_view/pages/category_pie_chart_page.dart';
import 'package:money_view/pages/daily_bar_chart_page.dart';

class Charts extends StatelessWidget {
  const Charts({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Charts')),
      backgroundColor: const Color.fromARGB(213, 132, 246, 250),
      body: Center(
        child: SizedBox(
          height: 900,
          width: 500,
          child: PageView(children: [CategoryCharts(), DailyBarChartPage()]),
        ),
      ),
    );
  }
}
