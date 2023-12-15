import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/data/domain/pizza.dart';

class UserPizzaTile extends StatefulWidget {
  final Pizza pizza;
  const UserPizzaTile({super.key, required this.pizza});

  @override
  State<StatefulWidget> createState() => _UserPizzaTileState();
}

class _UserPizzaTileState extends State<UserPizzaTile> {
  int currentQuantity = 0;
  late final Pizza pizza;

  @override
  void initState() {
    super.initState();
    pizza = widget.pizza;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => PizzaScreen(pizza: pizza),
      //   ),
      // ),
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
                      Text(
                        pizza.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      TextStyler.subtitle(context, pizza.ingredientsString()),
                    ],
                  ),
                ),
                Expanded(
                  child: _quantityChanger(),
                ),
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
        const Text("Quantity:"),
        InputQty.int(
          minVal: 1,
          steps: 1,
          initVal: 1,
          onQtyChanged: (val) {
            currentQuantity = val;
          },
        ),
        TextButton(
            onPressed: () => {
                  // TODO implement this
                },
            child: const Text("Add to Cart")),
      ],
    );
  }
}
