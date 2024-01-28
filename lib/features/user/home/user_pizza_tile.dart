import 'package:flutter/material.dart';
import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/user/home/pizza_sheet.dart';

class UserPizzaTile extends StatefulWidget {
  final Pizza pizza;
  const UserPizzaTile({super.key, required this.pizza});

  @override
  State<StatefulWidget> createState() => _UserPizzaTileState();
}

class _UserPizzaTileState extends State<UserPizzaTile> {
  late final Pizza pizza;

  @override
  void initState() {
    super.initState();
    pizza = widget.pizza;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PizzaSheet.showAsModalBottomSheet(context, pizza),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pizza.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  TextStyler.subtitle(context, pizza.ingredientsString()),
                  TextStyler.priceSection(context, pizza.price),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Image.asset(
                pizza.imagePath ?? "assets/pizza1.jpg",
                height: 80,
                width: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
