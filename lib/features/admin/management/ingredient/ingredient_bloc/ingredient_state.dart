part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  final String username;
  final List<Ingredient> ingredients;

  const IngredientState({required this.username, required this.ingredients});

  @override
  List<Object?> get props => [username, ingredients];
}

class IngredientInitial extends IngredientState {
  const IngredientInitial(
      {required super.username, required super.ingredients});
}

class IngredientLoaded extends IngredientState {
  const IngredientLoaded({required super.username, required super.ingredients});
}

class IngredientLoading extends IngredientState {
  const IngredientLoading(
      {required super.username, required super.ingredients});
}
