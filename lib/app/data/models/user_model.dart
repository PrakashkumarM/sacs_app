class UserModel {
  final String id;
  final String username;
  final String password;
  final String role;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  // Create a UserModel instance from a map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
    );
  }

  // Add a named constructor for default values
  factory UserModel.empty() {
    return UserModel(
      id: '',
      username: '',
      password: '',
      role: '',
    );
  }
}
