import 'dart:convert';
import 'dart:core';

import 'package:pizza_app/data/domain/pizza.dart';

import 'api_service.dart';

class PizzaService extends ApiService {
  final String pizzaUrl = "/pizzas";
  final String ingredientsSuburl = "/ingredients";
  PizzaService(super.dio);

  Future<Pizza> addPizza(Pizza pizza) async {
    final response = await dio.post(pizzaUrl, data: pizza.toMap());
    return Pizza.fromMap(jsonDecode(response.toString()));
  }

  Future<List<Pizza>> getPizzas() async {
    final response = await dio.get(
      pizzaUrl,
    );

    return (response.data as List<dynamic>)
        .map((e) => Pizza.fromMap(e))
        .toList();
  }

  // Future<User> updateUser(User user) async {
  //   final response = await dio.patch(userUrl, data: user.toJson());
  //   return User.fromJson(jsonDecode(response.toString()));
  // }

  // Future<void> deleteUser() async {
  //   await dio.delete(
  //     userUrl,
  //   );
  // }
}
