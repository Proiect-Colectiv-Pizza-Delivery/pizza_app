part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUser extends UserEvent {
  const FetchUser();

  @override
  List<Object?> get props => [];
}

class UpdateUser extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final File? profilePicture;

  const UpdateUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.username,
      required this.phoneNumber,
      this.profilePicture});

  @override
  List<Object?> get props =>
      [firstName, lastName, email, username, phoneNumber, profilePicture];
}
