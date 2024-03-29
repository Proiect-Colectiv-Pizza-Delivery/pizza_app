import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pizza_app/common/remote/pizza_service.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';

class PizzaRepositoryOnline extends PizzaRepository {
  final PizzaService _pizzaService;
  late List<Pizza>? _pizzas;
  int latestId = 11;

  PizzaRepositoryOnline(this._pizzaService) {
    super.databaseInitialized.complete();
  }

  @override
  Future<Pizza> addPizza(PizzaCreateRequest request) async {
    Pizza code = Pizza(
      id: latestId,
      name: request.name,
      price: request.price,
      ingredients: request.ingredients,
      available: true,
    );

    Pizza newPizza = await _pizzaService.addPizza(code);

    _pizzas!.insert(0, newPizza);
    latestId++;

    return newPizza;
  }

  @override
  Future<void> deletePizza(Pizza pizza) async {
    await _pizzaService.deletePizza(pizza.id);
    _pizzas!.remove(pizza);
  }

  @override
  Future<Pizza?> getPizza(String pizzaId) async {
    await initRepoIfNeeded();
    try {
      return _pizzas!.firstWhere((element) => element.id.toString() == pizzaId);
    } on StateError {
      return null;
    }
  }

  @override
  Future<List<Pizza>> getPizzas() async {
    // make sure that the list is as up-to-date as possible
    _pizzas = await _pizzaService.getPizzas();
    return _pizzas!;
  }

  @override
  Future<Pizza?> updatePizza(Pizza pizza) async {
    await _pizzaService.updatePizza(
        _pizzas!.firstWhere((element) => element.id == pizza.id), pizza);

    await initRepoIfNeeded();
    for (int i = 0; i < _pizzas!.length; i++) {
      if (_pizzas![i].id == pizza.id) {
        _pizzas![i] = pizza;
        return _pizzas![i];
      }
    }
    return null;
  }

  Future<void> initRepoIfNeeded() async {
    _pizzas ??= await _pizzaService.getPizzas();
  }
}
