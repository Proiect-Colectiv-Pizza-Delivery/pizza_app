import 'package:pizza_app/data/domain/pizza.dart';

class Order {
  final int id;
  final Map<Pizza, int> pizzas;
  final String? addressLineOne;
  final String? addressLineTwo;
  final double totalPrice;
  final DateTime date;
  final bool isPickUp;

  Order(
      {required this.id,
      required this.pizzas,
      required this.addressLineOne, this.addressLineTwo,
      required this.totalPrice,
      required this.date,
      required this.isPickUp});

  static List<Order> getPopulation() {
    List<Pizza> pizzaPopulation = Pizza.getPopulation();
    return [
      Order(
          id: 0,
          pizzas: {pizzaPopulation[1]: 2, pizzaPopulation[3]: 1},
          addressLineOne: "addressLineOne",
          addressLineTwo: "addressLineTwo",
          totalPrice: 300,
          date: DateTime.now(),
          isPickUp: false),
      Order(
          id: 1,
          pizzas: {pizzaPopulation[4]: 1, pizzaPopulation[6]: 3},
          addressLineOne: "addressLineOne",
          addressLineTwo: "addressLineTwo",
          totalPrice: 300,
          date: DateTime.now(),
          isPickUp: true),
      Order(
          id: 2,
          pizzas: {pizzaPopulation[5]: 3, pizzaPopulation[2]: 1},
          addressLineOne: "addressLineOne",
          addressLineTwo: "addressLineTwo",
          totalPrice: 300,
          date: DateTime.now(),
          isPickUp: false),
    ];
  }

  Order copyWith({
    int? id,
    Map<Pizza, int>? pizzas,
    String? addressLineOne,
    String? addressLineTwo,
    double? totalPrice,
    DateTime? date,
    bool? isPickUp,
  }) {
    return Order(
      id: id ?? this.id,
      pizzas: pizzas ?? this.pizzas,
      addressLineOne: addressLineOne ?? this.addressLineOne,
      addressLineTwo: addressLineTwo ?? this.addressLineTwo,
      totalPrice: totalPrice ?? this.totalPrice,
      date: date ?? this.date,
      isPickUp: isPickUp ?? this.isPickUp,
    );
  }
}
