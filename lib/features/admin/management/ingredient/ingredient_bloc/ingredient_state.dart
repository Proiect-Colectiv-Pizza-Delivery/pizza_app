part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  final List<Ingredient> ingredients;

  const IngredientState({required this.ingredients});

  @override
  List<Object?> get props => [ingredients];
}

class IngredientInitial extends IngredientState {
  const IngredientInitial({required super.ingredients});
}

class IngredientLoaded extends IngredientState {
  const IngredientLoaded({required super.ingredients});
}

class IngredientLoading extends IngredientState {
  const IngredientLoading({required super.ingredients});
}
