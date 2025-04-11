import 'package:flutter/material.dart';
import 'package:money_view/data/dataset.dart';
import 'package:money_view/widgets/custom_List_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Icon(Icons.home)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.97,
                color: Colors.red,
              ),
              const SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.535,
                width: MediaQuery.of(context).size.width * 0.97,
                color: const Color.fromARGB(255, 47, 94, 38),
                child: Column(
                  children: [
                    Text('Recent Expenses'),
                    const SizedBox(height: 3),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            Dataset().expenseData.length >= 7
                                ? 7
                                : Dataset().expenseData.length,
                        itemBuilder: (context, index) {
                          return CustomListTile(
                            expense: Dataset().expenseData[index],
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
