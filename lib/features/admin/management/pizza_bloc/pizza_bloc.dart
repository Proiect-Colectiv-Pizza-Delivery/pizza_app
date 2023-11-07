import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/data/domain/pizza_create_request.dart';
import 'package:pizza_app/data/repository/pizza_repository.dart';
import 'package:equatable/equatable.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  final PizzaRepository _pizzaRepository;

  PizzaBloc(this._pizzaRepository)
      : super(const PizzaInitial(username: "", codes: [])) {
    on<AddPizza>(_onAddPizza);
    on<UpdatePizza>(_onUpdatePizza);
    on<DeletePizza>(_onDeletePizza);
    on<FetchPizzas>(_onFetchPizzas);
    on<UpdateUsername>(_onUpdateUsername);
  }

  FutureOr<void> _onAddPizza(AddPizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(username: state.username, codes: state.codes));
    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.addPizza(PizzaCreateRequest(
        price: int.parse(event.price),
        name: event.name,
        ingredients: event.ingredients,
        available: event.available));

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(username: state.username, codes: newList));
  }

  FutureOr<void> _onUpdatePizza(
      UpdatePizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(username: state.username, codes: state.codes));

    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.updatePizza(Pizza(
        id: int.parse(event.pizzaId),
        price: int.parse(event.pizzaId),
        name: event.name,
        ingredients: event.ingredients,
        available: event.available));

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(username: state.username, codes: newList));
  }

  Future<FutureOr<void>> _onDeletePizza(
      DeletePizza event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(username: state.username, codes: state.codes));
    await _pizzaRepository.databaseInitialized.future;

    await _pizzaRepository.deletePizza(event.pizza);

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(username: state.username, codes: newList));
  }

  FutureOr<void> _onFetchPizzas(
      FetchPizzas event, Emitter<PizzaState> emit) async {
    emit(PizzaLoading(username: state.username, codes: state.codes));
    await _pizzaRepository.databaseInitialized.future;

    var newList = await _pizzaRepository.getPizzas();

    emit(PizzaLoaded(username: state.username, codes: newList));
  }

  FutureOr<void> _onUpdateUsername(
      UpdateUsername event, Emitter<PizzaState> emit) {
    emit(PizzaLoading(username: state.username, codes: state.codes));
    emit(PizzaLoaded(username: event.username, codes: state.codes));
  }
}
