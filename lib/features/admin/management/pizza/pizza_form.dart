import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/ingredient_selection_card.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';

class PizzaForm extends StatefulWidget {
  final PizzaFormType type;
  final Pizza? pizza;
  const PizzaForm({super.key, required this.type, this.pizza});

  @override
  State<PizzaForm> createState() => _PizzaFormState();
}

class _PizzaFormState extends State<PizzaForm> {
  late List<Ingredient> ingredients;
  final List<Ingredient> allIngredients = Ingredient.getPopulation();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.pizza != null) {
      ingredients = List<Ingredient>.of(widget.pizza!.ingredients);
      _nameController.text = widget.pizza!.name;
      _priceController.text = widget.pizza!.price.toString();
    } else {
      ingredients = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PizzaBloc, PizzaState>(
      listenWhen: (prev, current) =>
          prev is PizzaLoading && current is PizzaLoaded,
      listener: (context, state) => Navigator.of(context).pop(),
      builder: (context, state) => Scaffold(
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
                _textForm(),
                Expanded(child: _ingredientsList()),
                _doneButton(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textForm() {
    return Form(
      onChanged: () => setState(() {
        isButtonEnabled = _validateForm();
      }),
      child: Column(
        children: [
          TextInputField(
            controller: _nameController,
            validator: Validator.validateEmpty,
            labelText: "Pizza Name",
            enableSpaceKey: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextInputField(
              controller: _priceController,
              validator: Validator.validatePositiveInt,
              labelText: "Price",
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ingredientsList() {
    return BlocBuilder<IngredientBloc, IngredientState>(
      builder: (context, state) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              "Select Ingredients",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: state is IngredientLoaded ? ListView.builder(
              itemCount: state.ingredients.length,
              itemBuilder: (context, index) => IngredientSelectionCard(
                ingredient: state.ingredients[index],
                isSelected:
                    ingredients.contains(state.ingredients[index]),
                onSelect: () => setState(
                  () {
                    if (ingredients
                        .contains(state.ingredients[index])) {
                      ingredients.remove(state.ingredients[index]);
                    } else {
                      ingredients.add(state.ingredients[index]);
                    }
                    isButtonEnabled = _validateForm();
                  },
                ),
              ),
            ) : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _doneButton(PizzaState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DefaultButton(
        text: widget.type.getButtonLabel(),
        onPressed: isButtonEnabled ? _onDonePressed : null,
        isLoading: state is PizzaLoading,
      ),
    );
  }

  bool _validateForm() {
    return Validator.validateEmpty(_nameController.text) == null &&
        Validator.validatePositiveInt(_priceController.text) == null &&
        ingredients.isNotEmpty;
  }

  void _onDonePressed() {
    switch (widget.type) {
      case (PizzaFormType.add):
        BlocProvider.of<PizzaBloc>(context).add(
          AddPizza(
              price: _priceController.text,
              name: _nameController.text,
              ingredients: ingredients),
        );
      case (PizzaFormType.update):
        BlocProvider.of<PizzaBloc>(context).add(
          UpdatePizza(
              pizzaId: widget.pizza!.id,
              price: _priceController.text,
              name: _nameController.text,
              ingredients: ingredients),
        );
    }
  }
}

enum PizzaFormType {
  update,
  add;

  String getPageTitle() {
    switch (this) {
      case (update):
        return "Update Pizza";
      case (add):
        return "Create a new pizza";
    }
  }

  String getButtonLabel() {
    switch (this) {
      case (update):
        return "Update";
      case (add):
        return "Add";
    }
  }
}
