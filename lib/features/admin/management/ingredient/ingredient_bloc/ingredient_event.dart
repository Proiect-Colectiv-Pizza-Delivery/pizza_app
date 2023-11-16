part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object?> get props => [];
}

class FetchIngredients extends IngredientEvent {
  const FetchIngredients();
}

class DeleteIngredient extends IngredientEvent {
  final Ingredient ingredient;

  const DeleteIngredient(this.ingredient);

  @override
  List<Object> get props => [ingredient];
}

class AddIngredient extends IngredientEvent {
  final String name;
  final int quantity;
  final List<String> allergens;

  const AddIngredient(
      {required this.name, required this.quantity, required this.allergens});

  @override
  List<Object> get props => [name, quantity, allergens];
}

class UpdateIngredient extends IngredientEvent {
  final int ingredientId;
  final String name;
  final List<String> allergens;
  final int quantity;

  const UpdateIngredient(
      {required this.ingredientId,
      required this.name,
      required this.allergens,
      required this.quantity});

  @override
  List<Object> get props => [ingredientId, name, allergens, quantity];
}
