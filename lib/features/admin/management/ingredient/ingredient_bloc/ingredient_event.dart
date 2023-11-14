part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object?> get props => [];
}

class FetchIngredients extends IngredientEvent {
  const FetchIngredients();
}
