import 'package:flutter/material.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/features/admin/management/ingredient/allergen_selection_card.dart';

class IngredientForm extends StatefulWidget {
  final FormType type;
  final Ingredient? ingredient;
  const IngredientForm({super.key, required this.type, this.ingredient});

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.type.getPageTitle(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: AppColors.primary,
      body: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const TextInputField(
                labelText: "Ingredient Name",
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16),
              //   child: TextInputField(
              //     labelText: "Price",
              //     keyboardType: TextInputType.number,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "Select Allergens",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Ingredient.getPopulation().length,
                  itemBuilder: (context, index) => AllergenSelectionCard(
                      allergen: Ingredient.getAllergens()[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultButton(
                    text: "Done", onPressed: () => Navigator.of(context).pop()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FormType {
  update,
  add;

  String getPageTitle() {
    switch (this) {
      case (update):
        return "Update Ingredient";
      case (add):
        return "Create a New Ingredient";
    }
  }
}
