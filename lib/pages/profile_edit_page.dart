import 'package:flutter/material.dart';
import 'package:money_view/models/user_profile.dart';
import 'package:money_view/provider/profile_provider.dart';
import 'package:money_view/widgets/custom_button.dart';
import 'package:money_view/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

final List<String> avatarOptions = [
  'assets/avatar/male.png',
  'assets/avatar/female.png',
];

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();

  String? _selectedAvatarPath;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;
    if (profile != null) {
      _nameController.text = profile.name;
      _targetController.text = profile.target.toString();
      _selectedAvatarPath = profile.avatarPath;
    }
  }

  void _onSave() {
    String name = _nameController.text.trim();
    String targetStr = _targetController.text.trim();

    if (name.isEmpty || targetStr.isEmpty || _selectedAvatarPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and choose an avatar'),
        ),
      );
      return;
    }

    int? target = int.tryParse(targetStr);
    if (target == null || target < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Target must be an integer greater than 0'),
        ),
      );
      return;
    }

    final newProfile = UserProfile(
      name: name,
      target: target,
      avatarPath: _selectedAvatarPath!,
    );

    context.read<ProfileProvider>().saveProfile(newProfile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.pop(context);
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: avatarOptions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAvatarPath = avatarOptions[index];
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(avatarOptions[index]),
              ),
            );
          },
        );
      },
    );
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
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 10),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 60,
              backgroundImage:
                  _selectedAvatarPath != null
                      ? AssetImage(_selectedAvatarPath!)
                      : null,
              child:
                  _selectedAvatarPath == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
            ),
            TextButton(
              onPressed: () => _showAvatarPicker(context),
              child: const Text('Choose Avatar'),
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
          ],
        ),
      ),
    );
  }
}
