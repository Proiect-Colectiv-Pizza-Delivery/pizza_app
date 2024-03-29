part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUser extends UserEvent {
  final User? user;
  const FetchUser(this.user);

  @override
  List<Object?> get props => [];
}

class UpdateUser extends UserEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final File? profilePicture;

  const UpdateUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phoneNumber,
        required this.username,
      this.profilePicture});

  @override
  List<Object?> get props =>
      [firstName, lastName, email, password, phoneNumber, profilePicture];
}
