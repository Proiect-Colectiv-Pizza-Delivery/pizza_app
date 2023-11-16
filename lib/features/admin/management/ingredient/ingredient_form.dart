import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/features/admin/management/ingredient/allergen_selection_card.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';

class IngredientForm extends StatefulWidget {
  final FormType type;
  final Ingredient? ingredient;
  const IngredientForm({super.key, required this.type, this.ingredient});

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  List<String> allAllergens = Ingredient.getAllergens();
  List<String> allergens = [];
  bool isButtonEnabled = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      allergens = widget.ingredient!.allergens;
      _nameController.text = widget.ingredient!.name;
    } else {
      allAllergens = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IngredientBloc, IngredientState>(
        listenWhen: (prev, current) =>
            prev is PizzaLoading && current is PizzaLoaded,
        listener: (context, state) => Navigator.of(context).pop(),
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: Text(widget.type.getPageTitle(),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            backgroundColor: AppColors.primary,
            body: RoundedContainer(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(children: [
                  _textForm(),
                  Expanded(child: _allergensList()),
                  _doneButton(state)
                ]),
              ),
            )));
  }

  Widget _textForm() {
    return Form(
      onChanged: () => setState(() {
        isButtonEnabled = _validateForm();
      }),
      child: Column(children: [
        TextInputField(
          controller: _nameController,
          validator: Validator.validateEmpty,
          labelText: "Ingredient Name",
        ),
        TextInputField(
          controller: _quantityController,
          validator: Validator.,
        )
      ]),
    );
  }

  Widget _allergensList() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text("Select Allergens",
                style: Theme.of(context).textTheme.titleMedium)),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => AllergenSelectionCard(
                      allergen: allAllergens[index],
                      isSelected: allergens.contains(allAllergens[index]),
                      onSelect: () => setState(() {
                        if (allergens.contains(allAllergens[index])) {
                          allergens.remove(allAllergens[index]);
                        } else {
                          allergens.add(allAllergens[index]);
                        }
                        isButtonEnabled = _validateForm();
                      }),
                    ))),
      ],
    );
  }

  Widget _doneButton(state) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: DefaultButton(
          text: widget.type.getButtonLabel(),
          onPressed: isButtonEnabled ? _onDonePressed : null,
          isLoading: state is PizzaLoading,
        ));
  }

  bool _validateForm() {
    return Validator.validateEmpty(_nameController.text) == null;
  }

  void _onDonePressed() {
    switch (widget.type) {
      case (FormType.add):
        BlocProvider.of<IngredientBloc>(context).add(AddIngredient(
            name: _nameController.text,
            quantity: quantity,
            allergens: allergens));
      case (FormType.update):
        BlocProvider.of<IngredientBloc>(context).add(UpdateIngredient(
            ingredientId: widget.ingredient!.id,
            name: _nameController.text,
            allergens: allergens,
            quantity: quantity));
    }
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

  String getButtonLabel() {
    switch (this) {
      case (update):
        return "Update";
      case (add):
        return "Add";
    }
  }
}
