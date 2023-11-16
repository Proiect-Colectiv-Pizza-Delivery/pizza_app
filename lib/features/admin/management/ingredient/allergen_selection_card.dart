import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllergenSelectionCard extends StatelessWidget {
  final String allergen;
  final bool isSelected;
  final void Function()? onSelect;

  const AllergenSelectionCard(
      {super.key,
      required this.allergen,
      this.onSelect,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
          onTap: onSelect,
          child: isSelected
              ? SvgPicture.asset("assets/checked_radio_box.svg")
              : SvgPicture.asset("assets/empty_radio_box.svg")),
      title: Text(allergen, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
