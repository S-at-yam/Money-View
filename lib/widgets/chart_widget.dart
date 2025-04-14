import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartPage({required this.title, super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 900,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 94, 2, 2),
              ),
            ),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}
