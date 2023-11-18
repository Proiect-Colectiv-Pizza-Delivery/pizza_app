import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/allergen_selection_card.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_form.dart';

class IngredientScreen extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientScreen({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IngredientBloc, IngredientState>(
      listenWhen: (prev, current) =>
          prev is IngredientLoading && current is IngredientLoaded,
      listener: (context, state) => Navigator.of(context).pop(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(ingredient.name,
                  style: Theme.of(context).textTheme.titleLarge),
            ]),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Quantity: ${ingredient.quantity}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ingredient.allergens.length,
                    itemBuilder: (context, index) => AllergenSelectionCard(
                      allergen: ingredient.allergens[index],
                      isSelected: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DefaultButton(
                    text: "Update",
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IngredientForm(
                          type: IngredientFormType.update,
                          ingredient: ingredient,
                        ),
                      ),
                    ),
                  ),
                ),
                DefaultButton(
                    text: "Delete",
                    onPressed: () => {_onDeletePressed(context)},
                    isLoading: state is IngredientLoading)
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDeletePressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete Confirmation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
                "Are you sure you want to delete this ingredient? This action cannot be undone.",
                style: Theme.of(context).textTheme.bodyLarge),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",
                      style: Theme.of(context).textTheme.titleMedium)),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<IngredientBloc>(context)
                        .add(DeleteIngredient(ingredient));
                    Navigator.of(context).pop();
                  },
                  child: Text("OK",
                      style: Theme.of(context).textTheme.titleMedium))
            ],
          );
        });
  }

  void _showIngredientInfo(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return draggableIngredientInfo();
        });
  }

  Widget draggableIngredientInfo() {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.3,
      maxChildSize: 1,
      builder: (context, controller) => RoundedContainer(
        color: AppColors.white,
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  width: 30,
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    ingredient.allergens.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
