import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_screen.dart';
import 'package:input_quantity/input_quantity.dart';

class IngredientTile extends StatefulWidget {
  final Ingredient ingredient;
  const IngredientTile({super.key, required this.ingredient});

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  int currentQuantity = 0;
  late final Ingredient ingredient;

  @override
  void initState() {
    super.initState();
    ingredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IngredientScreen(ingredient: ingredient),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              ingredient.name,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      _subtitle(context, ingredient.allergensString()),
                    ],
                  ),
                ),
                Expanded(child: _quantityChanger()),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityChanger() {
    return Column(
      children: [
        Text("Quantity: ${ingredient.quantity}"),
        InputQty.int(
          minVal: 0,
          steps: 1,
          initVal: 0,
          onQtyChanged: (val) {
            currentQuantity = val;
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () => {_changeQuantity(-currentQuantity)},
                  child: const Text("Remove")),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () => {_changeQuantity(currentQuantity)},
                  child: const Text("Add")),
            )
          ],
        )
      ],
    );
  }

  Widget _subtitle(BuildContext context, String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.secondary,
            ),
      ),
      maxLines: 3,
    );
  }

  void _changeQuantity(int quantity) {
    BlocProvider.of<IngredientBloc>(context).add(UpdateIngredient(
        ingredientId: ingredient.id,
        name: ingredient.name,
        allergens: ingredient.allergens,
        quantity: max(ingredient.quantity + quantity, 0)));
  }
}
