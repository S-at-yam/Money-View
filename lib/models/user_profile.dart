class UserProfile {
  final String name;
  final int target;
  final String avatarPath;

  UserProfile({
    required this.name,
    required this.target,
    required this.avatarPath,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'target': target, 'avatarPath': avatarPath};
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'],
      target: map['target'],
      avatarPath: map['avatarPath'],
    );
  }
}
