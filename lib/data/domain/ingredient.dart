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
    return [
      Ingredient(
          id: 0, name: "Gorgonzola", allergens: ["lactose"], quantity: 100),
      Ingredient(
          id: 1, name: "Mozzarella", allergens: ["lactose"], quantity: 100),
      Ingredient(
          id: 2, name: "Goat cheese", allergens: ["lactose"], quantity: 100),
      Ingredient(
          id: 3, name: "Parmezan", allergens: ["lactose"], quantity: 100),
      Ingredient(
          id: 4,
          name: "Basic pizza base",
          allergens: ["gluten", "egg"],
          quantity: 100),
      Ingredient(
          id: 5,
          name: "Large pizza base",
          allergens: ["gluten", "egg"],
          quantity: 100),
      Ingredient(id: 6, name: "Tomato sauce", allergens: [], quantity: 1000),
      Ingredient(id: 7, name: "Olive oil", allergens: [], quantity: 1000),
      Ingredient(
          id: 8, name: "Chilli flakes", allergens: ["chilli"], quantity: 1000),
      Ingredient(
          id: 9, name: "Spicy salami", allergens: ["chilli"], quantity: 100),
      Ingredient(id: 10, name: "Pork sausage", allergens: [], quantity: 100),
      Ingredient(id: 11, name: "Basil", allergens: [], quantity: 1000),
      Ingredient(
          id: 12,
          name: "Parmezan pizza base",
          allergens: ["gluten", "egg", "lactose"],
          quantity: 1000),
      Ingredient(id: 13, name: "Pineapple", allergens: [], quantity: 100),
      Ingredient(id: 14, name: "Pork salami", allergens: [], quantity: 100),
      Ingredient(
          id: 15,
          name: "Ricotta pizza base",
          allergens: ["gluten", "egg", "lactose"],
          quantity: 1000),
      Ingredient(id: 16, name: "Garlic", allergens: [], quantity: 1000),
      Ingredient(id: 17, name: "Oregano", allergens: [], quantity: 1000),
      Ingredient(id: 18, name: "Mushroom", allergens: [], quantity: 100),
      Ingredient(id: 19, name: "Red onion", allergens: [], quantity: 100),
      Ingredient(id: 20, name: "Green pepper", allergens: [], quantity: 100),
      Ingredient(
          id: 21, name: "Feta cheese", allergens: ["lactose"], quantity: 100),
      Ingredient(
          id: 22, name: "Colorful Bell Peppers", allergens: [], quantity: 100),
      Ingredient(id: 23, name: "Avocado", allergens: [], quantity: 100),
      Ingredient(id: 24, name: "Lemon juice", allergens: [], quantity: 100),
      Ingredient(id: 25, name: "Fresh herbs", allergens: [], quantity: 100),
    ];
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
    return allergens.join(", ");
  }

  static List<String> getAllergens() {
    return [
      "egg",
      "gluten",
      "lactose",
      "chilli",
    ];
  }

  @override
  List<Object?> get props => [id, name, allergens, quantity];
}
