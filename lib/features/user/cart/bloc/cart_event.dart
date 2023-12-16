part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final Pizza pizza;
  final int quantity;

  const AddToCart(this.pizza, this.quantity);

  @override
  List<Object?> get props => [pizza, quantity];
}


class AddAddress extends CartEvent {
  final String lineOne;
  final String lineTwo;

  const AddAddress(this.lineOne, this.lineTwo);

  @override
  List<Object?> get props => [lineOne, lineTwo];
}


class RemoveFromCart extends CartEvent {
  final Pizza pizza;
  final int quantity;

  const RemoveFromCart(this.pizza, this.quantity);

  @override
  List<Object?> get props => [pizza, quantity];
}
