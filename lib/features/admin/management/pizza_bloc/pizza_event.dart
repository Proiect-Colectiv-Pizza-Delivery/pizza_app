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
  final List<Ingredient> ingredients;

  const AddPizza(
      {required this.price,
      required this.name,
      required this.ingredients,
      });

  @override
  List<Object?> get props => [price, name, ingredients];
}

class DeletePizza extends PizzaEvent {
  final Pizza pizza;

  const DeletePizza(this.pizza);

  @override
  List<Object?> get props => [pizza];
}

class UpdatePizza extends PizzaEvent {
  final String price;
  final int pizzaId;
  final String name;
  final List<Ingredient> ingredients;

  const UpdatePizza(
      {required this.price,
      required this.pizzaId,
      required this.name,
      required this.ingredients,});

  @override
  List<Object?> get props =>
      [price, pizzaId, name, ingredients];
}