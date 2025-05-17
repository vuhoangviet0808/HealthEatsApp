import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();                      

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String pw;

  const LoginEvent(this.email, this.pw);  

  @override
  List<Object?> get props => [email, pw];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String pw;

  const RegisterEvent(this.name, this.email, this.pw); 

  @override
  List<Object?> get props => [name, email, pw];
}