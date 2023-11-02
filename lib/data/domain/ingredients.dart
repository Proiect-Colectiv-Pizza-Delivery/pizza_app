import 'package:equatable/equatable.dart';

class Ingredients extends Equatable {
  final int id;
  final String name;
  final List<String> allergens;
  final int quantity;

  const Ingredients(
      {required this.id,
        required this.name,
        required this.allergens,
        required this.quantity
      });

  static List<Ingredients> getPopulation() {
    List<Ingredients> ingredients = [];

    for (int i = 1; i <= 10; i++) {
      Ingredients ingredient = Ingredients(
        id: i,
        name: 'ingredient$i',
        allergens: ['allergen $i', 'allergen ${i+1}','allergen ${i+2}', ],
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

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      id: map['id'],
      name: map['name'].toString(),
      quantity: map['description'],
      allergens: map['allergens'],
    );
  }

  @override
  List<Object?> get props =>
      [id, name, allergens, quantity];
}
