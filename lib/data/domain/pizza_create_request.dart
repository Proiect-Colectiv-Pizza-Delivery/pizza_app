import 'package:pizza_app/data/domain/ingredient.dart';

class PizzaCreateRequest {
  final int price;
  final String name;
  final List<Ingredient> ingredients;

  PizzaCreateRequest(
      {required this.price,
      required this.name,
      required this.ingredients,
      });
}
