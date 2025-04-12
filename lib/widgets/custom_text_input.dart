import 'package:flutter/material.dart';
import 'package:money_view/main.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final String? hintTextInput;
  final TextInputType? keyboard;
  final bool? readOnlyProp;
  final void Function()? onTap;
  const CustomTextInput({
    super.key,
    required this.textController,
    required this.labelText,
    this.hintTextInput,
    this.keyboard,
    this.readOnlyProp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 30,
      controller: textController,
      maxLines: null,
      readOnly: readOnlyProp ?? false,
      onTap: onTap ?? () {},
      keyboardType: keyboard ?? TextInputType.name,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: const Color.fromARGB(255, 75, 4, 4),
      ),
      decoration: InputDecoration(
        label: Text(labelText, softWrap: true),
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
