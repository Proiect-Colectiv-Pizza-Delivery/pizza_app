import 'dart:async';

import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/ingredient_create_request.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';
import 'package:pizza_app/data/repository/ingredient_repository.dart';
import 'package:pizza_app/data/repository/pizza_repository.dart';

class IngredientRepositoryImpl extends IngredientRepository {
  late List<Ingredient> _ingredients;
  int latestId = 11;

  IngredientRepositoryImpl() {
    _ingredients = Ingredient.getPopulation();
    super.databaseInitialized.complete();
  }

  @override
  Future<Ingredient> addIngredient(IngredientCreateRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    Ingredient code = Ingredient(
      id: latestId,
      name: request.name,
      allergens: request.allergens,
      quantity: request.quantity,
    );

    _ingredients.insert(0, code);
    latestId++;

    return code;
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) async {
    await Future.delayed(const Duration(seconds: 1));
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
    await Future.delayed(const Duration(seconds: 1));
    return _ingredients;
  }

  @override
  Future<Ingredient?> updateIngredient(Ingredient ingredient) async {
    await Future.delayed(const Duration(seconds: 1));
    for (int i = 0; i < _ingredients.length; i++) {
      if (_ingredients[i].id == ingredient.id) {
        _ingredients[i] = ingredient;
        return _ingredients[i];
      }
    }
    return null;
  }
}
