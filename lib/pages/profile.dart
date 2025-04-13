import 'package:flutter/material.dart';
import 'package:money_view/provider/profile_provider.dart';
import 'package:money_view/pages/profile_edit_page.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

    if (profile == null) {
      // No profile yet — show setup button
      return Scaffold(
        appBar: AppBar(title: const Text('Your Profile')),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileEditPage()),
              );
            },
            icon: const Icon(Icons.person_add),
            label: const Text(
              'Set up your profile',
              style: TextStyle(color: Color.fromARGB(255, 117, 63, 1)),
            ),
          ),
        ),
      );
    }

    // Profile exists — show details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileEditPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),

        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(profile.avatarPath),
                backgroundColor: const Color.fromARGB(255, 83, 78, 78),
              ),
              const SizedBox(height: 20),
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 16, 2, 82),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Target: ₹${profile.target}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 17, 9, 87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
