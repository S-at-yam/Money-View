import 'package:flutter/material.dart';
import 'package:money_view/data/dataset.dart';
import 'package:money_view/widgets/custom_List_tile.dart';

class History extends StatelessWidget {
  const History({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: Dataset().expenseData.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 3, 8, 2),
            child: CustomListTile(expense: Dataset().expenseData[index]),
          );
        },
      ),
    );
  }
}
