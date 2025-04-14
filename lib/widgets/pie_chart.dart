import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class ExpensePieChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const ExpensePieChart({required this.data, super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensePieChartState();
  }
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double total = widget.data.fold(0, (sum, item) => sum + item['total']);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pie chart widget
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            child: PieChart(
              PieChartData(
                sections: List.generate(widget.data.length, (index) {
                  final item = widget.data[index];
                  final percentage = (item['total'] / total) * 100;
                  var categoryName = item['category'];
                  categoryName = categoryName.toString().toUpperCase();

                  return PieChartSectionData(
                    color: _getColor(index),
                    value: item['total'],
                    title:
                        touchedIndex == index
                            ? '$categoryName\n${item['total']}'
                            : (touchedIndex == -1
                                ? '${percentage.toStringAsFixed(1)}%'
                                : ''),
                    radius: touchedIndex == index ? 100 : 80,
                    titlePositionPercentageOffset: 0.5,
                    titleStyle: TextStyle(
                      fontSize: touchedIndex == index ? 20 : 16,
                      color: const Color.fromARGB(255, 251, 252, 251),
                    ),
                  );
                }),
                sectionsSpace: 1,
                centerSpaceRadius: 50,
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      touchedIndex =
                          response?.touchedSection?.touchedSectionIndex ?? -1;
                    });
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.data.length, (index) {
                final item = widget.data[index];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 12, height: 12, color: _getColor(index)),
                    const SizedBox(width: 8),
                    Text(
                      item['category'].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 66, 1, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(int index) {
    final colors = [
      const Color.fromARGB(255, 1, 36, 65),
      const Color.fromARGB(255, 95, 8, 2),
      const Color.fromARGB(255, 1, 75, 4),
      const Color.fromARGB(255, 88, 54, 1),
      const Color.fromARGB(255, 67, 1, 78),
      const Color.fromARGB(255, 83, 78, 2),
      const Color.fromARGB(255, 32, 1, 15),
      const Color.fromARGB(255, 63, 1, 20),
    ];
    return colors[index % colors.length];
  }
}
