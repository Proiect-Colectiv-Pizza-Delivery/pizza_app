import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/ingredient_create_request.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientRepository _ingredientRepository;

  IngredientBloc(this._ingredientRepository)
      : super(const IngredientInitial(ingredients: [])) {
    on<FetchIngredients>(_onFetchIngredients);
    on<DeleteIngredient>(_onDeleteIngredient);
    on<AddIngredient>(_onAddIngredient);
    on<UpdateIngredient>(_onUpdateIngredient);
  }

  FutureOr<void> _onFetchIngredients(
      FetchIngredients event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading(ingredients: state.ingredients));
    await _ingredientRepository.databaseInitialized.future;

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(ingredients: newList));
  }

  Future<FutureOr<void>> _onDeleteIngredient(
      DeleteIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading(ingredients: state.ingredients));
    await _ingredientRepository.deleteIngredient(event.ingredient);

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(ingredients: newList));
  }

  FutureOr<void> _onAddIngredient(
      AddIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading(ingredients: state.ingredients));

    await _ingredientRepository.databaseInitialized.future;

    await _ingredientRepository.addIngredient(IngredientCreateRequest(
        name: event.name,
        allergens: event.allergens,
        quantity: event.quantity));

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(ingredients: newList));
  }

  FutureOr<void> _onUpdateIngredient(
      UpdateIngredient event, Emitter<IngredientState> emit) async {
    await _ingredientRepository.databaseInitialized.future;

    _ingredientRepository.updateIngredient(Ingredient(
        id: event.ingredientId,
        name: event.name,
        allergens: event.allergens,
        quantity: event.quantity));

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(ingredients: newList));
  }
}
