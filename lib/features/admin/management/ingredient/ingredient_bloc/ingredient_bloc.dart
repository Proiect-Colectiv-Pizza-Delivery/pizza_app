import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/repository/ingredient_repository.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientRepository _ingredientRepository;

  IngredientBloc(this._ingredientRepository)
      : super(const IngredientInitial(username: "", ingredients: [])) {
    on<FetchIngredients>(_onFetchIngredients);
    on<DeleteIngredient>(_onDeleteIngredient);
  }

  FutureOr<void> _onFetchIngredients(
      FetchIngredients event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading(
        username: state.username, ingredients: state.ingredients));
    await _ingredientRepository.databaseInitialized.future;

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(username: state.username, ingredients: newList));
  }

  Future<FutureOr<void>> _onDeleteIngredient(
      DeleteIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading(
        username: state.username, ingredients: state.ingredients));
    await _ingredientRepository.deleteIngredient(event.ingredient);

    var newList = await _ingredientRepository.getIngredients();

    emit(IngredientLoaded(username: state.username, ingredients: newList));
  }
}
