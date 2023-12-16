import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/domain/order.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/repository/orders/order_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final OrderRepository _orderRepository;

  CartBloc(this._orderRepository) : super(const CartInitial({}, {})) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<AddAddress>(_onAddAddress);
    on<ConfirmOrder>(_onConfirmOrder);
  }

  FutureOr<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    Map<Pizza, int> currentCart = Map.from(state.cartMap);
    if (currentCart.containsKey(event.pizza)) {
      currentCart[event.pizza] = currentCart[event.pizza]! + event.quantity;
    } else {
      currentCart[event.pizza] = event.quantity;
    }
    emit(CartLoaded(currentCart, state.address));
  }

  FutureOr<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) {
    Map<Pizza, int> currentCart = Map.from(state.cartMap);
    if (currentCart.containsKey(event.pizza)) {
      currentCart[event.pizza] = currentCart[event.pizza]! - event.quantity;
      if (currentCart[event.pizza]! < 1) {
        currentCart.remove(event.pizza);
      }
    }
    emit(CartLoaded(currentCart, state.address));
  }

  FutureOr<void> _onAddAddress(AddAddress event, Emitter<CartState> emit) {
    Map<String, String> currentAddresses = Map.from(state.address);
    currentAddresses[event.lineOne] = event.lineTwo;
    emit(CartLoaded(state.cartMap, currentAddresses));
  }

  Future<FutureOr<void>> _onConfirmOrder(
      ConfirmOrder event, Emitter<CartState> emit) async {
    emit(CartLoading(state.cartMap, state.address));
    await _orderRepository.addOrder(Order(
        id: 0,
        pizzas: state.cartMap,
        addressLineOne: event.addressLineOne,
        addressLineTwo: event.addressLineTwo,
        totalPrice: event.totalPrice,
        date: DateTime.now(),
        isPickUp: event.isPickup));
    emit(CartLoaded(const {}, state.address));
  }
}
