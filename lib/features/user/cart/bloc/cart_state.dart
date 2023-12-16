part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final Map<Pizza, int> cartMap;
  final Map<String, String> address;

  const CartState(this.cartMap, this.address);

  @override
  List<Object?> get props => [cartMap, address];
}

class CartInitial extends CartState {
  const CartInitial(super.cartMap, super.address);
}

class CartLoading extends CartState {
  const CartLoading(super.cartMap, super.address);
}

class CartLoaded extends CartState {
  const CartLoaded(super.cartMap, super.address);
}
