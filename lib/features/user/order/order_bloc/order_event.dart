part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class AddToOrder extends OrderEvent {
  final Pizza pizza;
  final int quantity;

  const AddToOrder({required this.pizza, required this.quantity});

  @override
  List<Object?> get props => [pizza, quantity];
}

class RemoveFromOrder extends OrderEvent {
  final int id;

  const RemoveFromOrder({required this.id});

  @override
  List<Object?> get props => [id];
}

class ResetOrder extends OrderEvent {
  const ResetOrder();
}
