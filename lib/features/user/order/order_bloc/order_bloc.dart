import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/domain/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<OrderItem> items = [];
  OrderBloc() : super(const InitialOrderState(items: [])) {
    on<AddToOrder>(_addToOrder);
    on<RemoveFromOrder>(_removeFromOrder);
    on<ResetOrder>(_resetOrder);
  }

  FutureOr<void> _addToOrder(AddToOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading(items: items));

    items.add(OrderItem(pizza: event.pizza, quantity: event.quantity));

    emit(OrderLoaded(items: items));
  }

  FutureOr<void> _removeFromOrder(
      RemoveFromOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading(items: items));

    for (var item in items) {
      if (item.pizza.id == event.id) {
        items.remove(item);
        break;
      }
    }

    emit(OrderLoaded(items: items));
  }

  FutureOr<void> _resetOrder(ResetOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading(items: items));

    items = [];

    emit(OrderLoaded(items: items));
  }
}
