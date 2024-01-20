import 'dart:core';

import 'package:pizza_app/data/domain/ingredient.dart';

import 'api_service.dart';

class IngredientService extends ApiService {
  final String ingredientsUrl = "/ingredients";
  IngredientService(super.dio, super._authInterceptor);

  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    final response = await dio.post(ingredientsUrl, data: ingredient.toMap());
    return Ingredient.fromMap(response.data);
  }

  Future<List<Ingredient>> getIngredients() async {
    final response = await dio.get(
      ingredientsUrl,
    );

    return (response.data as List<dynamic>)
        .map((e) => Ingredient.fromMap(e))
        .toList();
  }

  Future<Ingredient> getIngredient(int id) async {
    final response = await dio.get(
      "$ingredientsUrl/$id",
    );

    return Ingredient.fromMap(response.data);
  }

  Future<Ingredient> updateIngredient(Ingredient ingredient) async {
    Map<String, dynamic> ingredientMap = ingredient.toMap();
    ingredientMap.putIfAbsent("id", () => ingredient.id);
    final response =
        await dio.put("$ingredientsUrl/${ingredient.id}", data: ingredientMap);
    return Ingredient.fromMap(response.data);
  }

  Future<void> deleteIngredient(int id) async {
    await dio.delete(
      "$ingredientsUrl/$id",
    );
  }
}
