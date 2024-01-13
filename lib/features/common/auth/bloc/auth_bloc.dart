import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/data/auth/auth_repository.dart';
import 'package:pizza_app/data/domain/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(Unauthenticated()) {
    on<LogIn>(_onLogIn);
  }

  FutureOr<void> _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    var user = await authRepository.login();
    if(user != null) {
      log("user id: ${user.id}");
      log("auth headers: ${await user.authHeaders}");
      log("display name: ${user.displayName}");
      log("server auth code: ${user.serverAuthCode}");
      var auth = await user.authentication;
      log("accessToken: ${auth.accessToken}");
      log("idToken: ${auth.idToken}");
      emit(Authenticated(user));
    } else{
      emit(Unauthenticated());
    }
  }
}
