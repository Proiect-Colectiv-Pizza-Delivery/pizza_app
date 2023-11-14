import 'dart:async';

import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/ingredient_create_request.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';

abstract class IngredientRepository {
  final Completer databaseInitialized = Completer();

  Future<Ingredient> addIngredient(IngredientCreateRequest request);

  Future<List<Ingredient>> getIngredients();

  Future<Ingredient?> getIngredient(String ingredientId);

  Future<Ingredient?> updateIngredient(Ingredient ingredient);

  Future<void> deleteIngredient(Ingredient ingredient);
}
