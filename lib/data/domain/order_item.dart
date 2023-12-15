import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/domain/pizza.dart';

class OrderItem extends Equatable {
  final Pizza pizza;
  final int quantity;

  const OrderItem({required this.pizza, this.quantity = 1});

  @override
  List<Object?> get props => [pizza, quantity];
}
