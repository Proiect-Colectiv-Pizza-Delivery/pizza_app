import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int id;
  final String name;
  final List<String> allergens;
  final int quantity;

  const Ingredient(
      {required this.id,
      required this.name,
      required this.allergens,
      required this.quantity});

  static List<Ingredient> getPopulation() {
    List<Ingredient> ingredients = [];

    for (int i = 1; i <= 10; i++) {
      Ingredient ingredient = Ingredient(
        id: i,
        name: 'ingredient$i',
        allergens: [
          'allergen $i',
          'allergen ${i + 1}',
          'allergen ${i + 2}',
        ],
        quantity: i * 5,
      );

      ingredients.add(ingredient);
    }
    return ingredients;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'allergens': allergens,
      'quantity': quantity,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'].toString(),
      quantity: map['description'],
      allergens: map['allergens'],
    );
  }

  String allergensString() {
    var string = "";
    for (var i in allergens) {
      string += "$i, ";
    }

    return string.substring(0, string.length - 2);
  }

  @override
  List<Object?> get props => [id, name, allergens, quantity];
}
