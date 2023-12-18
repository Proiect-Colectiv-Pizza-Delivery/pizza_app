import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/domain/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User user;
  UserBloc(this.user)
      : super(const InitialUserState(
            user: User(
                firstName: "Emil",
                lastName: "Yung",
                email: "emil_yung@gmail.com",
                username: "eyung",
                phoneNumber: "+40758978965"))) {
    on<UpdateUser>(_updateUser);
    on<FetchUser>(_fetchUser);
  }

  FutureOr<void> _fetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserLoading(user: user));

    user = const User(
        firstName: "Emil",
        lastName: "Yung",
        email: "emil_yung@gmail.com",
        username: "eyung",
        phoneNumber: "+40758978965");

    emit(UserLoaded(user: user));
  }

  FutureOr<void> _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading(user: user));

    user = User(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        username: event.username,
        phoneNumber: event.phoneNumber,
        profilePicture: event.profilePicture);

    emit(UserLoaded(user: user));
  }
}
