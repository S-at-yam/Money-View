import 'package:flutter/material.dart';
import 'package:money_view/main.dart';
import 'package:money_view/models/expense.dart';
import 'package:money_view/pages/update_expense.dart';

class CustomListTile extends StatelessWidget {
  final Expense expense;

  const CustomListTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(expense.id),
      background: Container(color: Colors.red),
      child: ListTile(
        tileColor: kColorScheme.secondaryContainer,
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => UpdateExpense()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              expense.dateDay,
              style: TextStyle(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
            Text(
              expense.dateMonth,
              style: TextStyle(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 15,
              ),
            ),
          ],
        ),
        title: Text(
          expense.title[0].toUpperCase() +
              expense.title.substring(1).toLowerCase(),
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontSize: 20,
          ),
        ),
        trailing: Text(
          '₹${expense.amount}',
          style: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontSize: 15,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Icon(categoryIcons[expense.category])],
        ),
      ),
    );
  }
}
