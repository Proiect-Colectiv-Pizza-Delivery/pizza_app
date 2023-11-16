import 'dart:async';

import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';

abstract class PizzaRepository {
  final Completer databaseInitialized = Completer();

  Future<Pizza> addPizza(PizzaCreateRequest request);

  Future<List<Pizza>> getPizzas();

  Future<Pizza?> getPizza(String pizzaId);

  Future<Pizza?> updatePizza(Pizza pizza);

  Future<void> deletePizza(Pizza pizza);
}
