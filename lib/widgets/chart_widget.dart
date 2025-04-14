import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartPage({required this.title, super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        width: MediaQuery.of(context).size.width * 0.98,

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

            chart,
          ],
        ),
      ),
    );
  }
}
