import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'root_page_event.dart';
part 'root_page_state.dart';

class RootPageBloc extends Bloc<RootPageEvent, RootPageState> {
  RootPageBloc() : super(const RootPageLoaded(0)) {
    on<ChangePage>((event, emit) {
      emit(RootPageLoaded(event.index));
    });
  }
}
