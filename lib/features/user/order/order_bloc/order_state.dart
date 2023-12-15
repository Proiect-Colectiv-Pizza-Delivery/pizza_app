part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  final List<OrderItem> items;

  const OrderState({required this.items});

  @override
  List<Object?> get props => [items];
}

class InitialOrderState extends OrderState {
  const InitialOrderState({required super.items});
}

class OrderLoading extends OrderState {
  const OrderLoading({required super.items});
}

class OrderLoaded extends OrderState {
  const OrderLoaded({required super.items});
}
