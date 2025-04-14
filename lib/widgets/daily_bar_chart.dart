import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> dailyData;
  final int daysOfMonth;

  const DailyBarChart({
    required this.dailyData,
    super.key,
    required this.daysOfMonth,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String mmm = DateFormat('MMMM').format(now);

    final Map<int, double> dayTotals = {
      for (var row in dailyData)
        if (row['day'] != null && row['total'] != null)
          int.parse(row['day']): row['total'] * 1.0,
    };

    final int maxDays = daysOfMonth;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            'Expenses in $mmm',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          AspectRatio(
            aspectRatio: 0.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,

                      getTitlesWidget:
                          (value, _) => Text(
                            '₹${value.toInt()}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 170, 3, 3),
                            ),
                          ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: maxDays > 15 ? 5 : 1,
                      getTitlesWidget:
                          (value, _) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.black,
                            ),
                          ),
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: List.generate(maxDays, (index) {
                  final day = index + 1;
                  final total = dayTotals[day] ?? 0.0;

                  return BarChartGroupData(
                    x: day,
                    barRods: [
                      BarChartRodData(
                        toY: total,
                        width: 6,
                        color:
                            total > 0
                                ? const Color.fromARGB(255, 0, 24, 65)
                                : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
