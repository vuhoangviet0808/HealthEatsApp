import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDS remote;
  AuthRepoImpl(this.remote);

  @override
  Future<Either<String, User>> login(String email, String pw) =>
      remote.login(email, pw);

  @override
  Future<Either<String, void>> register(
          String name, String email, String pw) =>
      remote.register(name, email, pw);
}
