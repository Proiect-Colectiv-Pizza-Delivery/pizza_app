import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/data/domain/ingredient.dart';

class IngredientSelectionCard extends StatelessWidget {
  final Ingredient ingredient;
  final void Function()? onSelect;
  final bool isSelected;

  const IngredientSelectionCard(
      {super.key,
      required this.ingredient,
        this.onSelect,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
        onTap: onSelect,
        child: isSelected
            ? SvgPicture.asset(
                "assets/checked_radio_box.svg",
              )
            : SvgPicture.asset("assets/empty_radio_box.svg"),
      ),
      title:
          Text(ingredient.name, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        ingredient.allergens
            .toString()
            .substring(1, ingredient.allergens.toString().length - 1),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
