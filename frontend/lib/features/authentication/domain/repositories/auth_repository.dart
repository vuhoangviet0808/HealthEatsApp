import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login(String email, String pw);
  Future<Either<String, void>> register(String name, String email, String pw);
}
