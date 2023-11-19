class IngredientCreateRequest {
  final String name;
  final List<String> allergens;
  final int quantity;

  IngredientCreateRequest({
    required this.name,
    required this.allergens,
    required this.quantity,
  });
}
