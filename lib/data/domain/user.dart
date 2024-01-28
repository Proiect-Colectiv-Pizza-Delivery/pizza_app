import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String userName;
  final String lastName;
  final String email;
  final String? password;
  final String phoneNumber;
  final UserRole role;
  final File? profilePicture;
  const User(
      {required this.firstName,
      required this.lastName,
        required this.userName,
      required this.email,
        this.password,
      required this.phoneNumber,
        this.role = UserRole.user,
      this.profilePicture});

  @override
  List<Object?> get props =>
      [firstName, lastName, email, password, phoneNumber, profilePicture, role];

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'username': userName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role.roleName,
    };
  }


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      userName: json['userName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: UserRole.fromString(json['roles'][0] ?? ''),
    );
  }
}

enum UserRole{
  user("ROLE_USER"),
  admin("ROLE_ADMIN"),
  unknown("");

  final String roleName;

  const UserRole(this.roleName);

  static UserRole fromString(String roleName){
    switch(roleName){
      case("ROLE_USER"):
        return UserRole.user;
      case("ROLE_ADMIN"):
        return UserRole.admin;
      default:
        return UserRole.unknown;
    }
  }
}
