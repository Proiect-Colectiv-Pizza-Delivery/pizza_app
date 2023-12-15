import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_screen.dart';
import 'package:flutter/material.dart';

class PizzaTile extends StatelessWidget {
  final Pizza pizza;
  const PizzaTile({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PizzaScreen(pizza: pizza),
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
                              pizza.name,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                      TextStyler.subtitle(context, pizza.ingredientsString()),
                    ],
                  ),
                )
              ],
            ),
          ),
          // if (pizza.available)
          //   Container(
          //     color: AppColors.red.withOpacity(0.4),
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Expanded(
          //                     child: Center(
          //                       child: Text(
          //                         "Not Available",
          //                         style: Theme.of(context).textTheme.titleLarge,
          //                         overflow: TextOverflow.ellipsis,
          //                         maxLines: 1,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
