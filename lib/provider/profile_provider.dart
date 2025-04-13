import 'package:flutter/material.dart';

import 'package:money_view/data/profile_database_helper.dart';

import 'package:money_view/models/user_profile.dart';

class ProfileProvider with ChangeNotifier {
  UserProfile? _profile;
  final _dbHelper = ProfileDatabaseHelper();

  UserProfile? get profile => _profile;

  Future<void> loadProfile() async {
    _profile = await _dbHelper.getProfile();
    notifyListeners();
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _dbHelper.insertOrUpdateProfile(profile);
    _profile = profile;
    notifyListeners();
  }

  Future<void> clearProfile() async {
    await _dbHelper.deleteProfile();
    _profile = null;
    notifyListeners();
  }
}
