import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class RegisterUC {
  final AuthRepository repo;
  const RegisterUC(this.repo);
  Future<Either<String, void>> call(String name,String email,String pw)=>
      repo.register(name,email,pw);
}
