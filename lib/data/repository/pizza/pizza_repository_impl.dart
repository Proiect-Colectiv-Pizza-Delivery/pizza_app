import 'dart:async';

import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';

class PizzaRepositoryImpl extends PizzaRepository {
  late List<Pizza> _pizzas;
  int latestId = 11;

  PizzaRepositoryImpl() {
    _pizzas = Pizza.getPopulation();
    super.databaseInitialized.complete();
  }

  @override
  Future<Pizza> addPizza(PizzaCreateRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    Pizza code = Pizza(
        id: latestId,
        name: request.name,
      price: request.price,
        ingredients: request.ingredients,
      available: request.available,
    );

    _pizzas.insert(0, code);
    latestId++;

    return code;
  }

  @override
  Future<void> deletePizza(Pizza pizza) async {
    await Future.delayed(const Duration(seconds: 1));
    _pizzas.remove(pizza);
  }

  @override
  Future<Pizza?> getPizza(String pizzaId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return _pizzas
          .firstWhere((element) => element.id.toString() == pizzaId);
    } on StateError {
      return null;
    }
  }

  @override
  Future<List<Pizza>> getPizzas() async {
    await Future.delayed(const Duration(seconds: 1));
    return _pizzas;
  }

  @override
  Future<Pizza?> updatePizza(Pizza pizza) async {
    await Future.delayed(const Duration(seconds: 1));
    for (int i = 0; i < _pizzas.length; i++) {
      if (_pizzas[i].id == pizza.id) {
        _pizzas[i] = pizza;
        return _pizzas[i];
      }
    }
    return null;
  }
}
