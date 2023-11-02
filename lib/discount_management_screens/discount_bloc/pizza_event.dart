part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object?> get props => [];
}

class FetchPizzas extends PizzaEvent {
  const FetchPizzas();
}

class AddPizza extends PizzaEvent {
  final String price;
  final String name;
  final List<Ingredients> ingredients;
  final bool available;

  const AddPizza(
      {required this.price,
      required this.name,
      required this.ingredients,
      required this.available});

  @override
  List<Object?> get props => [price, name, ingredients, available];
}

class DeletePizza extends PizzaEvent {
  final Pizza pizza;

  const DeletePizza(this.pizza);

  @override
  List<Object?> get props => [pizza];
}

class UpdatePizza extends PizzaEvent {
  final String price;
  final String pizzaId;
  final String name;
  final List<Ingredients> ingredients;
  final bool available;

  const UpdatePizza(
      {required this.price,
      required this.pizzaId,
      required this.name,
      required this.ingredients,
      required this.available});

  @override
  List<Object?> get props =>
      [price, pizzaId, name, ingredients, available];
}

class UpdateUsername extends PizzaEvent {
  final String username;

  const UpdateUsername(this.username);

  @override
  List<Object?> get props => [username];
}
