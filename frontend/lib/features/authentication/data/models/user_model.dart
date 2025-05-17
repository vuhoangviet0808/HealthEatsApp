import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.email, required super.username});

  factory UserModel.fromJson(Map<String, dynamic> j) =>
      UserModel(email: j['email'], username: j['username']);
}
