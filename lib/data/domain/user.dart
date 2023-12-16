import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  const User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.username,
      required this.phoneNumber});

  @override
  List<Object?> get props =>
      [firstName, lastName, email, username, phoneNumber];
}
