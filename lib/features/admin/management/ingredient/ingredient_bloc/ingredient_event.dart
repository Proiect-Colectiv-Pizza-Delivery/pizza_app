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
