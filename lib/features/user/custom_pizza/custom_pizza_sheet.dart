import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/user/home/pizza_sheet.dart';

class CustomPizzaSheet extends StatefulWidget {
  final ScrollController scrollController;

  const CustomPizzaSheet({super.key, required this.scrollController});

  static void showAsModalBottomSheet(BuildContext context) {
    DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();
    showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return DraggableScrollableSheet(
          controller: draggableScrollableController,
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) =>
              CustomPizzaSheet(scrollController: scrollController),
        );
      },
    ).then((value) => draggableScrollableController.dispose());
  }

  @override
  State<CustomPizzaSheet> createState() => _CustomPizzaSheetState();
}

class _CustomPizzaSheetState extends State<CustomPizzaSheet> {
  late Pizza pizza;
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    List<Pizza> cartContent =
        BlocProvider.of<CartBloc>(context).state.cartMap.keys.toList();
    int customPizzaCount = 0;
    for (Pizza pizza in cartContent) {
      if (pizza.name.contains("Custom")) {
        customPizzaCount++;
      }
    }

    pizza = Pizza(
        id: -1,
        price: 30,
        name:
            "Custom Pizza${customPizzaCount > 0 ? " #$customPizzaCount" : ""}",
        ingredients: const [],
        imagePath: "assets/full_pizza_icon.png",
        available: true);

    BlocProvider.of<IngredientBloc>(context).add(const FetchIngredients());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IngredientBloc, IngredientState>(
      listener: (context, state) {
        if (state is IngredientLoaded) {
          ingredients.clear();
          ingredients.add(
            BlocProvider.of<IngredientBloc>(context)
                .state
                .ingredients
                .firstWhere((element) => element.name == "Basic pizza base"),
          );
        }
      },
      builder: (context, state) => RoundedContainer(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              controller: widget.scrollController,
              child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Image.asset(
                              "assets/full_pizza_icon.png",
                              height: 250,
                              width: 250,
                            ),
                          ),
                        ),
                        state is IngredientLoaded ?
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pizza.name,
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              TextStyler.priceSection(context, 30),
                              ...buildIngredientsTiles(state.ingredients),
                            ],
                          ),
                        ) : const CircularProgressIndicator(),
                        SizedBox(
                          height: state is IngredientLoaded ? 100 : 500,
                        ),
                      ],
                    ),
            ),
            AddSection(pizza: pizza.copyWith(ingredients: ingredients))
          ],
        ),
      ),
    );
  }

  List<Widget> buildIngredientsTiles(List<Ingredient> ingredientList) {
    List<Widget> widgetList = [];
    Ingredient baseIngredient = ingredientList
        .firstWhere((element) => element.name == "Basic pizza base");
    widgetList.add(ingredientTile(baseIngredient, isFixed: true));
    for (Ingredient ingredient in ingredientList) {
      if (!ingredient.name.contains("base")) {
        widgetList.add(ingredientTile(ingredient));
      }
    }
    return widgetList;
  }

  ListTile ingredientTile(Ingredient ingredient, {bool isFixed = false}) {
    return ListTile(
      title: Text(ingredient.name),
      subtitle: Text(ingredient.allergensString()),
      trailing: isFixed
          ? SvgPicture.asset("assets/checked_radio_box_gray.svg")
          : ingredients.contains(ingredient)
              ? SvgPicture.asset("assets/checked_radio_box.svg")
              : SvgPicture.asset("assets/empty_radio_box.svg"),
      onTap: () {
        if (!isFixed) {
          setState(
            () {
              if (ingredients.contains(ingredient)) {
                ingredients.remove(ingredient);
              } else {
                ingredients.add(ingredient);
              }
            },
          );
        }
      },
    );
  }
}
