import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  final PizzaRepository _pizzaRepository;

  PizzaBloc(this._pizzaRepository) : super(const PizzaInitial(pizzas: [])) {
    on<AddPizza>(_onAddPizza);
    on<UpdatePizza>(_onUpdatePizza);
    on<DeletePizza>(_onDeletePizza);
    on<FetchPizzas>(_onFetchPizzas);
  }

  FutureOr<void> _onAddPizza(AddPizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(pizzas: state.pizzas));
    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.addPizza(PizzaCreateRequest(
      price: double.parse(event.price),
      name: event.name,
      ingredients: event.ingredients,
    ));

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(pizzas: newList));
  }

  FutureOr<void> _onUpdatePizza(
      UpdatePizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(pizzas: state.pizzas));

    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.updatePizza(
      Pizza(
          id: event.pizzaId,
          price: double.parse(event.price),
          name: event.name,
          ingredients: event.ingredients,
          available: true),
    );

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(pizzas: newList));
  }

  Future<FutureOr<void>> _onDeletePizza(
      DeletePizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(pizzas: state.pizzas));
    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.deletePizza(event.pizza);

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(pizzas: newList));
  }

  FutureOr<void> _onFetchPizzas(
      FetchPizzas event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(pizzas: state.pizzas));
    await _pizzaRepository.databaseInitialized.future;

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(pizzas: newList));
  }
}
