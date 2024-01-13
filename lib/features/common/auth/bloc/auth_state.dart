part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class Authenticated extends AuthState {
  final GoogleSignInAccount user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
