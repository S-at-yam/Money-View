import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_view/main.dart';
import 'package:money_view/models/expense.dart';
import 'package:money_view/provider/expense_provider.dart';
import 'package:money_view/widgets/custom_button.dart';
import 'package:money_view/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class UpdateExpense extends StatefulWidget {
  final Expense expense;

  const UpdateExpense({super.key, required this.expense});

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  late TextEditingController _amountController;
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _dateController;

  late DateTime _selectedDate;
  late Category _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.expense.date;
    _selectedCategory = widget.expense.category;

    _titleController = TextEditingController(text: widget.expense.title);
    _amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );
    _descController = TextEditingController(
      text: widget.expense.description ?? '',
    );
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('yMMMd').format(date);
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
        _dateController.text = _formatDate(_selectedDate);
      });
    }
  }

  void _onSave() {
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim();

    if (title.isEmpty ||
        amountText.isEmpty ||
        double.tryParse(amountText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid title and amount')),
      );
      return;
    }

    final updatedExpense = Expense(
      id: widget.expense.id, // Keep same ID
      title: title,
      amount: double.parse(amountText),
      category: _selectedCategory,
      date: _selectedDate,
      description:
          _descController.text.trim().isEmpty
              ? null
              : _descController.text.trim(),
    );

    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).updateExpense(updatedExpense).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Expense updated')));
      Navigator.pop(context, true); // Return success to previous screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Expense')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
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
      ),
    );
  }
}
