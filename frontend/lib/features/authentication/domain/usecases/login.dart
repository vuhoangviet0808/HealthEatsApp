import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class LoginUC {
  final AuthRepository repo;
  const LoginUC(this.repo);
  Future<Either<String, User>> call(String email, String pw) =>
      repo.login(email, pw);
}
