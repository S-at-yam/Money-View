import 'package:flutter/material.dart';
import 'package:money_view/main.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final String? hintTextInput;
  final TextInputType? keyboard;
  const CustomTextInput({
    super.key,
    required this.textController,
    required this.labelText,
    this.hintTextInput,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 30,
      controller: textController,

      keyboardType: keyboard ?? TextInputType.name,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: kColorScheme.outline, fontSize: 20),
        hintText: hintTextInput ?? '',

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
      ),
    );
  }
}
