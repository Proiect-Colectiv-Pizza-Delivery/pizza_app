import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/auth/auth_repository.dart';
import 'package:pizza_app/data/domain/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(Unauthenticated()) {
    on<LogIn>(_onLogIn);
    on<SendAuthInformation>(_onSendAuthInformation);
  }

  FutureOr<void> _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    var user = await authRepository.login(event.username, event.password);
    if(user != null) {
      print(user.toString());
      emit(Authenticated(user));
    } else{
      emit(Unauthenticated());
    }
  }


  FutureOr<void> _onSendAuthInformation(SendAuthInformation event, Emitter<AuthState> emit) {
    authRepository.sendAccountInfo();
  }
}
