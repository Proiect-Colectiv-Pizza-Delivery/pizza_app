import 'package:flutter/material.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/features/user/custom_pizza/custom_pizza_sheet.dart';

class CustomPizzaBanner extends StatelessWidget {
  const CustomPizzaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.orange.withOpacity(0.5), // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(32),
        color: AppColors.yellow, // Background color
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.3),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: Image.asset(
                    "assets/pizza_icon.png",
                    height: 55,
                    width: 55,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customize & Conquer!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Craft your perfect pizza,\njust the way you like it",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width * 0.7,
              child: DefaultButton(
                  onPressed: () {
                    CustomPizzaSheet.showAsModalBottomSheet(context);
                  },
                  text: "Create Yours Now!"),
            )
          ],
        ),
      ),
    );
  }
}
