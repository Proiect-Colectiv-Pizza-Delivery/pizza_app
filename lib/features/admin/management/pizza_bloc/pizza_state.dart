part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  final String username;
  final List<Pizza> codes;

  const PizzaState({required this.username, required this.codes});

  @override
  List<Object?> get props => [username, codes];
}

class PizzaInitial extends PizzaState {
  const PizzaInitial({required super.username, required super.codes});
}

class PizzaLoading extends PizzaState {
  const PizzaLoading({required super.username, required super.codes});
}

class PizzaLoaded extends PizzaState {
  const PizzaLoaded({required super.username, required super.codes});
}

class PizzaError extends PizzaState {
  final String message;
  final PizzaErrorReason reason;

  const PizzaError(
      {required super.username,
      required super.codes,
      required this.message,
      required this.reason});

  @override
  List<Object> get props => [username, message, reason];
}

enum PizzaErrorReason {
  invalidField;
}
