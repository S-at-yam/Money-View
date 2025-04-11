import 'package:flutter/material.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddNewState();
  }
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new Expense')),
      body: Text('Add new Expense'),
    );
  }
}
