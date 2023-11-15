import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllergenSelectionCard extends StatefulWidget {
  final String allergen;
  final bool alwaysSelected;
  const AllergenSelectionCard(
      {super.key, required this.allergen, this.alwaysSelected = false});

  @override
  State<AllergenSelectionCard> createState() => _AllergenSelectionCardState();
}

class _AllergenSelectionCardState extends State<AllergenSelectionCard> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: !widget.alwaysSelected
          ? GestureDetector(
              onTap: () => setState(() {
                isCompleted = !isCompleted;
              }),
              child: isCompleted
                  ? SvgPicture.asset(
                      "assets/checked_radio_box.svg",
                    )
                  : SvgPicture.asset("assets/empty_radio_box.svg"),
            )
          : SvgPicture.asset(
              "assets/checked_radio_box.svg",
            ),
      title:
          Text(widget.allergen, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
