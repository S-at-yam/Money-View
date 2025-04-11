import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your profile')),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.97,
        padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: Center(
                child: CircleAvatar(backgroundColor: Colors.amber, radius: 80),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextInput(
              textController: _nameController,
              labelText: 'Enter your name',
            ),
            const SizedBox(height: 15),
            CustomTextInput(
              textController: _targetController,
              labelText: 'Enter your target expenditure',
              hintTextInput: 'e.g. 10000',
            ),
          ],
        ),
      ),
    );
  }
}
