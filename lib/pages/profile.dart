import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_view/widgets/custom_button.dart';

import 'package:money_view/widgets/custom_text_input.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();

  void _onSave() {
    String name = _nameController.text;
    String target = _targetController.text;

    if (name == 'null' ||
        name.trim().isEmpty ||
        target == 'null' ||
        target.trim().isEmpty) {
      return;
    } else {
      log(name);
      log(target);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(title: Text('Your profile')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, keyboardSpace + 5),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.97,
          padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
                child: Column(
                  children: [
                    CircleAvatar(backgroundColor: Colors.amber, radius: 80),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Choose Your Avatar',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 8, 2, 61),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              CustomTextInput(
                textController: _nameController,
                labelText: 'Enter your name',
              ),

              const SizedBox(height: 15),
              CustomTextInput(
                textController: _targetController,
                labelText: 'Enter your target expenditure',
                hintTextInput: 'e.g. 10000',
                keyboard: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(children: [const Spacer(), CustomButton(onTap: _onSave)]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
