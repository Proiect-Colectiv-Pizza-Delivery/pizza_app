import 'dart:core';

import 'package:pizza_app/data/domain/pizza.dart';

import 'api_service.dart';

class PizzaService extends ApiService {
  final String pizzaUrl = "/pizzas";
  final String ingredientsSuburl = "/ingredients";
  PizzaService(super.dio, super._authInterceptor);

  Future<Pizza> addPizza(Pizza pizza) async {
    Map<String, dynamic> code = pizza.toMap();
    code.putIfAbsent("id", () => pizza.id);
    final response = await dio.post(pizzaUrl, data: code);
    Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    var data = {
      "pizzaId": response.data["id"],
      "ingredientsIdList": pizza.ingredients
          .map((i) => {"ingredientId": i.id, "quantity": 1})
          .toList()
    };

    await dio.post("$pizzaUrl/updateIngredients", data: data);

    responseData.putIfAbsent("ingredients", () => []);
    Pizza newPizza = Pizza.fromMap(responseData);
    newPizza.ingredients.addAll(pizza.ingredients);

    return newPizza;
  }

  Future<List<Pizza>> getPizzas() async {
    final response = await dio.get(
      "$pizzaUrl/ingredients",
    );

    return (response.data as List<dynamic>)
        .map((e) => Pizza.fromMap(e))
        .toList();
  }

  Future<Pizza> updatePizza(Pizza oldPizza, Pizza pizza) async {
    // update pizza info
    Map<String, dynamic> data = pizza.toMap();
    data.putIfAbsent("id", () => pizza.id);

    final response = await dio.put("$pizzaUrl/${pizza.id}", data: data);

    // remove all old ingredients
    data = {
      "pizzaId": pizza.id,
      "ingredientsList": oldPizza.ingredients.map((e) => e.id).toList()
    };

    await dio.delete('$pizzaUrl/removeIngredients', data: data);

    // add new ingredients
    data = {
      "pizzaId": response.data["id"],
      "ingredientsIdList": pizza.ingredients
          .map((i) => {"ingredientId": i.id, "quantity": 1})
          .toList()
    };

    await dio.post("$pizzaUrl/updateIngredients", data: data);

    // create pizza to return
    Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    responseData.putIfAbsent("ingredients", () => []);
    Pizza newPizza = Pizza.fromMap(responseData);
    newPizza.ingredients.addAll(pizza.ingredients);

    return newPizza;
  }

  Future<void> deletePizza(int id) async {
    await dio.delete(
      "$pizzaUrl/$id",
    );
  }
}
