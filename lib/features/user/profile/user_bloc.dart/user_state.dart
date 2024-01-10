part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final User user;

  const UserState({required this.user});

  @override
  List<Object?> get props => [user];
}

class InitialUserState extends UserState {
  const InitialUserState({required super.user});
}

class UserLoading extends UserState {
  const UserLoading({required super.user});
}

class UserLoaded extends UserState {
  const UserLoaded({required super.user});
}
