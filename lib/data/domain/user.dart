import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final File? profilePicture;
  const User(
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
