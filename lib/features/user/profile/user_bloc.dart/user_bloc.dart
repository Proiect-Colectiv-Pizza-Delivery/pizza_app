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
  UserBloc(this.user) : super(InitialUserState(user: user)) {
    on<UpdateUser>(_updateUser);
    on<FetchUser>(_fetchUser);
  }

  FutureOr<void> _fetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserLoading(user: user));

    emit(UserLoaded(user: user));
  }

  FutureOr<void> _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading(user: user));

    user = User(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
        profilePicture: event.profilePicture,
        userName: event.username);

    await Future.delayed(Duration(seconds: 1));

    emit(UserLoaded(user: user));
  }
}
