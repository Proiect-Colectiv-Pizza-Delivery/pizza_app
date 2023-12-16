part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUser extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;

  const UpdateUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.username,
      required this.phoneNumber});

  @override
  List<Object?> get props =>
      [firstName, lastName, email, username, phoneNumber];
}
