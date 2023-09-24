
class UserModel {
  int? id;
  final String userName;
  final String mail;
  final String password;

  UserModel({this.id, required this.userName, required this.mail, required this.password});

  static UserModel fromJson(Map<String, dynamic> map) {
  return UserModel(
    id: map['id'] as int?,
    userName: map['userName'] as String? ?? '', // Provide a default empty string if 'userName' is null
    mail: map['mail'] as String? ?? '',         // Provide a default empty string if 'mail' is null
    password: map['password'] as String? ?? '', // Provide a default empty string if 'password' is null
  );
}

   
}
