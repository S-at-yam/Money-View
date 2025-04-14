import 'package:flutter/material.dart';
import 'package:money_view/pages/category_pie_chart_page.dart';
import 'package:money_view/pages/daily_bar_chart_page.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ChartsState();
  }
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Charts')),
      backgroundColor: const Color.fromARGB(213, 132, 246, 250),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.79,
          width: MediaQuery.of(context).size.width * 0.99,

          child: PageView(children: [CategoryCharts(), DailyBarChartPage()]),
        ),
      ),
    );
  }
}
