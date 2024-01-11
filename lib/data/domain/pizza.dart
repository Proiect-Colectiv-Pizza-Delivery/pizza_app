import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:pizza_app/data/domain/ingredient.dart';

class Pizza extends Equatable {
  final int id;
  final int price;
  final String name;
  final List<Ingredient> ingredients;
  final bool available;
  final String? imagePath;

  const Pizza({
    required this.id,
    required this.price,
    required this.name,
    required this.ingredients,
    required this.available,
    this.imagePath
  });

  static List<Pizza> getPopulation() {
    final List<Ingredient> ingrs = Ingredient.getPopulation();
    return [
      Pizza(
          id: 1,
          price: 30,
          name: "Quattro Formaggi",
          ingredients: [ingrs[4], ingrs[6], ...ingrs.sublist(0, 4)],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"
      ),
      Pizza(
          id: 2,
          price: 32,
          name: "Diavola",
          ingredients: [ingrs[4], ...ingrs.sublist(6, 11)],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"
      ),
      Pizza(
          id: 3,
          price: 22,
          name: "Margherita",
          ingredients: [ingrs[12], ...ingrs.sublist(6, 8), ingrs[1], ingrs[11]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 4,
          price: 29,
          name: "Hawaiian",
          ingredients: [ingrs[4], ingrs[6], ingrs[13], ingrs[14], ingrs[1]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 5,
          price: 30,
          name: "Spicy Hawaiian",
          ingredients: [ingrs[4], ingrs[6], ingrs[13], ingrs[9], ingrs[1]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 6,
          price: 30,
          name: "Extra Spicy Hawaiian",
          ingredients: [
            ingrs[4],
            ingrs[6],
            ingrs[13],
            ingrs[9],
            ingrs[8],
            ingrs[1]
          ],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 7,
          price: 27,
          name: "Pizza Bianca",
          ingredients: [ingrs[15], ingrs[1], ingrs[3], ingrs[16]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 8,
          price: 28,
          name: "Veggie Supreme",
          ingredients: [ingrs[4], ...ingrs.sublist(18, 22), ingrs[17]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 9,
          price: 26,
          name: "Goat Cheese Pizza",
          ingredients: [ingrs[4], ingrs[6], ingrs[19], ingrs[2], ingrs[11]],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 10,
          price: 27,
          name: "Veggie Pizza with Avoicade",
          ingredients: [
            ingrs[4],
            ingrs[6],
            ingrs[2],
            ingrs[22],
            ingrs[23],
            ingrs[11]
          ],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg"),
      Pizza(
          id: 11,
          price: 26,
          name: "Mushroom Pizza",
          ingredients: [
            ingrs[4],
            ingrs[18],
            ingrs[2],
            ingrs[1],
            ingrs[25],
            ingrs[24]
          ],
          available: true,
          imagePath: "assets/pizza${Random().nextInt(5) + 1}.jpg")
    ];
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
    return ingredients.map((e) => e.name).join(", ");
  }

  Pizza copyWith({
    int? id,
    int? price,
    String? name,
    List<Ingredient>? ingredients,
    bool? available,
    String? imagePath,
  }) {
    return Pizza(
      id: id ?? this.id,
      price: price ?? this.price,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      available: available ?? this.available,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [id, name, price, ingredients, available];
}
