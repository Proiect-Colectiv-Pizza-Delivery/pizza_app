import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/data/domain/ingredient.dart';

class IngredientSelectionCard extends StatefulWidget {
  final Ingredient ingredient;
  final bool alwaysSelected;
  const IngredientSelectionCard({super.key, required this.ingredient, this.alwaysSelected = false});

  @override
  State<IngredientSelectionCard> createState() =>
      _IngredientSelectionCardState();
}

class _IngredientSelectionCardState extends State<IngredientSelectionCard> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: !widget.alwaysSelected ? GestureDetector(
        onTap: () => setState(() {
          isCompleted = !isCompleted;
        }),
        child: isCompleted
            ? SvgPicture.asset("assets/checked_radio_box.svg",)
            : SvgPicture.asset("assets/empty_radio_box.svg"),
      ) : SvgPicture.asset("assets/checked_radio_box.svg",),
      title: Text(widget.ingredient.name,
          style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        widget.ingredient.allergens
            .toString()
            .substring(1, widget.ingredient.allergens.toString().length - 1),
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
