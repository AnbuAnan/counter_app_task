class UserModel {
  String? email;
  String? password;
  String? name;
  DateTime? createdAt;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    DateTime? createdAt,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'createdAt': createdAt!.toIso8601String(),
  };

  factory UserModel.formJson(Map<String, dynamic> user) {
    return UserModel(
      email: user['email'],
      password: user['password'],
      name: user['name'],
      createdAt: DateTime.parse(user['createdAt']),
    );
  }
}
