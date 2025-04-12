import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_view/main.dart';
import 'package:money_view/models/expense.dart';

import 'package:money_view/provider/expense_provider.dart';
import 'package:money_view/widgets/custom_button.dart';
import 'package:money_view/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddNewState();
  }
}

class _AddNewState extends State<AddNew> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  Category _selectedCategory = Category.others;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String dateForm(DateTime date) {
    String formatedDate = DateFormat('yMMMd').format(date);
    return formatedDate;
  }

  void _onSave() {
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim();

    if (title.isEmpty ||
        amountText.isEmpty ||
        double.tryParse(amountText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid title and amount')),
      );
      return;
    }

    final newExpense = Expense(
      title: title,
      amount: double.parse(amountText),
      category: _selectedCategory,
      date: _selectedDate,
      description:
          _descController.text.trim().isEmpty
              ? null
              : _descController.text.trim(),
    );

    // Use Provider to save
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).addExpense(newExpense).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Expense saved!')));
    });
    Navigator.pop(context);
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = dateForm(_selectedDate);
        log(_selectedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new Expense')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            //color: Colors.red,
            child: Column(
              children: [
                CustomTextInput(
                  textController: _titleController,
                  labelText: 'Title',
                  keyboard: TextInputType.name,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextInput(
                        textController: _amountController,
                        labelText: 'Amount',
                        keyboard: TextInputType.number,
                        hintTextInput: 'in Rupees',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items:
                            Category.values.map((Category cat) {
                              return DropdownMenuItem<Category>(
                                value: cat,
                                child: Text(
                                  cat.name.toUpperCase(),
                                  style: TextStyle(
                                    color: kColorScheme.onPrimaryContainer,
                                  ),
                                ),
                              );
                            }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(
                            color: kColorScheme.onSecondaryFixed,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  textController: _dateController,
                  labelText: 'Select a date',
                  readOnlyProp: true,
                  onTap: _pickDate,
                  keyboard: TextInputType.datetime,
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  textController: _descController,
                  labelText: 'Description',
                  keyboard: TextInputType.name,
                  hintTextInput: 'Optional',
                ),
                const SizedBox(height: 50),
                CustomButton(onTap: _onSave),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
