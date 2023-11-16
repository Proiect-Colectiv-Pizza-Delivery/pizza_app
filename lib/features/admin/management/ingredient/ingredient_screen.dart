import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/allergen_selection_card.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';

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
            title: GestureDetector(
                onTap: () => _showIngredientInfo(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      ingredient.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                  ],
                )),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  "Quantity: ${ingredient.quantity}",
                  style: Theme.of(context).textTheme.titleLarge,
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
                  onPressed: () => BlocProvider.of<IngredientBloc>(context).add(
                    DeleteIngredient(ingredient),
                  ),
                  isLoading: state is PizzaLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
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
