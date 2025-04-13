import 'package:money_view/models/user_profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfileDatabaseHelper {
  static final ProfileDatabaseHelper _instance =
      ProfileDatabaseHelper._internal();
  factory ProfileDatabaseHelper() => _instance;
  ProfileDatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'profile.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE profile (
            name TEXT PRIMARY KEY,
            target INTEGER,
            avatarPath TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertOrUpdateProfile(UserProfile profile) async {
    final dbClient = await db;
    await dbClient.insert(
      'profile',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserProfile?> getProfile() async {
    final dbClient = await db;
    final result = await dbClient.query('profile', limit: 1);
    if (result.isNotEmpty) {
      return UserProfile.fromMap(result.first);
    }
    return null;
  }

  Future<void> deleteProfile() async {
    final dbClient = await db;
    await dbClient.delete('profile');
  }
}
