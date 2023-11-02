import 'package:pizza_app/data/domain/ingredients.dart';

class PizzaCreateRequest {
  final int price;
  final String name;
  final List<Ingredients> ingredients;
  final bool available;

  PizzaCreateRequest(
      {required this.price,
      required this.name,
      required this.ingredients,
      required this.available,
      });
}
