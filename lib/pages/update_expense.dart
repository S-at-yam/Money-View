import 'package:flutter/material.dart';

class UpdateExpense extends StatefulWidget {
  const UpdateExpense({super.key});
  @override
  State<StatefulWidget> createState() {
    return _UpdateExpenseState();
  }
}

class _UpdateExpenseState extends State<UpdateExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit your Expense')),
      body: Text('Edit'),
    );
  }
}
