import 'package:flutter/material.dart';
import 'package:money_view/main.dart';
import 'package:money_view/models/expense.dart';

class CustomListTile extends StatelessWidget {
  final Expense expense;

  const CustomListTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(expense.id),
      child: ListTile(
        tileColor: kColorScheme.secondaryContainer,
        onTap: () {},
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
          '₹' + expense.amount.toString(),
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
