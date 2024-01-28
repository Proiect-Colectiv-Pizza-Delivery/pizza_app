import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/domain/order.dart';
import 'package:pizza_app/data/repository/orders/order_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final OrderRepository _orderRepository;

  HistoryBloc(this._orderRepository) : super(const HistoryInitial([])) {
    on<FetchHistory>(_onFetchHistory);
  }

  FutureOr<void> _onFetchHistory(
      FetchHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading(state.orders));
    await _orderRepository.databaseInitialized.future;
    var orders = await _orderRepository.getOrders();
    emit(HistoryLoaded(orders));
  }
}
