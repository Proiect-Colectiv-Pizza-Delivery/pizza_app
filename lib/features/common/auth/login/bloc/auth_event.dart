part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogIn extends AuthEvent{
  final String username;
  final String password;

  const LogIn({required this.username, required this.password});

 @override
  List<Object?> get props => [username, password];
}

class SendAuthInformation extends AuthEvent{}

class SignOut extends AuthEvent{}