import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) => const AddAddressSheet());
  }

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final TextEditingController _lineOneController = TextEditingController();
  final TextEditingController _lineTwoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _cityController.text = "Cluj Napoca";
    _countyController.text = "Cluj";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: RoundedContainer(
        height: 450,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _textForm(),
                DefaultButton(
                  text: "Save",
                  onPressed: isButtonEnabled
                      ? () {
                          BlocProvider.of<CartBloc>(context).add(
                            AddAddress(_lineOneController.text,
                                _lineTwoController.text),
                          );
                          Navigator.pop(context);
                        }
                      : null,
                ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField(
            controller: _lineOneController,
            validator: Validator.validateEmpty,
            labelText: "Address line 1",
            enableSpaceKey: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextInputField(
              controller: _lineTwoController,
              labelText: "Address line 2 (optional)",
              enableSpaceKey: true,
            ),
          ),
          TextInputField(
            controller: _cityController,
            labelText: "City",
            enabled: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextInputField(
              enabled: false,
              controller: _countyController,
              labelText: "County",
            ),
          ),
        ],
      ),
    );
  }

  bool _validateForm() {
    return Validator.validateEmpty(_lineOneController.text) == null;
  }
}
