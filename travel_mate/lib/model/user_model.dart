
class UserModel {
  int? id;
  final String? image;
  final String username;
  final String mail;
  final String password;

  UserModel( {this.id,required this.image, required this.username, required this.mail, required this.password});

  static UserModel fromJson(Map<String, dynamic> map) {
  return UserModel(
    id: map['id'] as int?,
    image: map['image'],
    username: map['username'] as String? ?? '', 
    mail: map['mail'] as String? ?? '',        
    password: map['password'] as String? ?? '',  
  );
}

   
}
