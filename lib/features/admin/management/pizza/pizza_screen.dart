import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/dialogs.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/ingredient_selection_card.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';

class PizzaScreen extends StatelessWidget {
  final Pizza pizza;
  const PizzaScreen({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PizzaBloc, PizzaState>(
      listenWhen: (prev, current) =>
          prev is PizzaLoading && current is PizzaLoaded,
      listener: (context, state) => Navigator.of(context).pop(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  pizza.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  pizza.price.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Icon(Icons.attach_money_rounded),
              ],
            ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: pizza.ingredients.length,
                    itemBuilder: (context, index) => IngredientSelectionCard(
                      ingredient: pizza.ingredients[index],
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
                        builder: (context) => PizzaForm(
                          type: PizzaFormType.update,
                          pizza: pizza,
                        ),
                      ),
                    ),
                  ),
                ),
                DefaultButton(
                  text: "Delete",
                  onPressed: () => {_onDeletePressed(context)},
                  isLoading: state is PizzaLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _section(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDeletePressed(BuildContext context) {
    NativeDialog(
        title: 'Delete Confirmation',
        content:
            "Are you sure you want to delete this pizza? This action cannot be undone.",
        firstButtonText: "Cancel",
        secondButtonText: "Ok",
        onFirstButtonPress: () => Navigator.of(context).pop(),
        onSecondButtonPress: () {
          BlocProvider.of<PizzaBloc>(context).add(DeletePizza(pizza));
          Navigator.of(context).pop();
        }).showOSDialog(context);
  }

  void _showPizzaInfo(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return draggablePizzaInfo();
        });
  }

  Widget draggablePizzaInfo() {
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
                    pizza.ingredients.toString(),
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
