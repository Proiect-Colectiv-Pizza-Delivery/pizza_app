import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/domain/ingredient.dart';

class Pizza extends Equatable {
  final int id;
  final int price;
  final String name;
  final List<Ingredient> ingredients;
  final bool available;

  const Pizza({
    required this.id,
    required this.price,
    required this.name,
    required this.ingredients,
    required this.available,
  });

  static List<Pizza> getPopulation() {
    List<Pizza> pizzas = [];
    List<Ingredient> ingredients = Ingredient.getPopulation();

    for (int i = 0; i <= 5; i++) {
      Pizza pizza = Pizza(
          id: i,
          price: i * 2,
          name: 'Pizza$i',
          ingredients: ingredients,
          available: i % 2 == 0);

      pizzas.add(pizza);
    }
    return pizzas;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'available': available,
      'price': price
    };
  }

  factory Pizza.fromMap(Map<String, dynamic> map) {
    return Pizza(
      id: map['id'],
      name: map['name'].toString(),
      ingredients: map['ingredients'],
      available: map['available'],
      price: map['price'],
    );
  }

  String ingredientsString() {
    var string = "";
    for (var i in ingredients) {
      string += "${i.name}, ";
    }

    return string.substring(0, string.length - 2);
  }

  @override
  List<Object?> get props => [id, name, price, ingredients, available];
}
