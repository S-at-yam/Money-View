import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;

  const CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          const Color.fromARGB(255, 9, 1, 77),
        ),
      ),
      child: Text('Save'),
    );
  }
}
