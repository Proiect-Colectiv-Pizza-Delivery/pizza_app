part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  final List<Pizza> pizzas;

  const PizzaState({required this.pizzas});

  @override
  List<Object?> get props => [pizzas];
}

class PizzaInitial extends PizzaState {
  const PizzaInitial({required super.pizzas});
}

class PizzaLoading extends PizzaState {
  const PizzaLoading({required super.pizzas});
}

class PizzaLoaded extends PizzaState {
  const PizzaLoaded({required super.pizzas});
}

class PizzaError extends PizzaState {
  final String message;
  final PizzaErrorReason reason;

  const PizzaError(
      {required super.pizzas,
      required this.message,
      required this.reason});

  @override
  List<Object> get props => [message, reason];
}

enum PizzaErrorReason {
  invalidField;
}
