import 'package:flutter/material.dart';
import 'package:money_view/main.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    super.key,
    required this.textController,
    required this.labelText,
    this.hintTextInput,
  });

  final TextEditingController textController;
  final String labelText;
  String? hintTextInput;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 30,
      controller: textController,

      keyboardType: TextInputType.name,
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
