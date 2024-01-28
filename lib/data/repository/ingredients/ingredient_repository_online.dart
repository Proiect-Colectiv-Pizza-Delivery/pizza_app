import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pizza_app/common/remote/ingredient_service.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/ingredient_create_request.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';

class IngredientRepositoryOnline extends IngredientRepository {
  late List<Ingredient> _ingredients;
  final IngredientService _ingredientService;
  int latestId = 11;

  IngredientRepositoryOnline(this._ingredientService) {
    initialize();
  }

  Future<void> initialize() async {
    super.databaseInitialized.complete();
  }

  @override
  Future<Ingredient> addIngredient(IngredientCreateRequest request) async {
    Ingredient code = Ingredient(
      id: latestId,
      name: request.name,
      allergens: request.allergens,
      quantity: request.quantity,
    );

    Ingredient newIngredient = await _ingredientService.addIngredient(code);

    _ingredients.insert(0, newIngredient);
    latestId++;

    return newIngredient;
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) async {
    await _ingredientService.deleteIngredient(ingredient.id);
    _ingredients.remove(ingredient);
  }

  @override
  Future<Ingredient?> getIngredient(String ingredientId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return _ingredients
          .firstWhere((element) => element.id.toString() == ingredientId);
    } on StateError {
      return null;
    }
  }

  @override
  Future<List<Ingredient>> getIngredients() async {
    _ingredients = await _ingredientService.getIngredients();
    return _ingredients;
  }

  @override
  Future<Ingredient?> updateIngredient(Ingredient ingredient) async {
    ingredient = await _ingredientService.updateIngredient(ingredient);

    for (int i = 0; i < _ingredients.length; i++) {
      if (_ingredients[i].id == ingredient.id) {
        _ingredients[i] = ingredient;
        return _ingredients[i];
      }
    }
    return null;
  }
}
