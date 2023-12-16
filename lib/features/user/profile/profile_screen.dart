import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/features/user/profile/user_bloc.dart/user_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isButtonEnabled = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setFields(BlocProvider.of<UserBloc>(context).state.user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => RoundedContainer(
                child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "${state.user.username}'s Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _textForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DefaultButton(
                    text: "Update Profile",
                    onPressed:
                        isButtonEnabled ? () => _onDonePressed(state) : null,
                    isLoading: state is UserLoading,
                  ),
                )
              ]),
            )));
  }

  void _setFields(User user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneNumberController.text = user.phoneNumber;
  }

  Widget _textForm() {
    return Form(
      onChanged: () => setState(() {
        isButtonEnabled = _validateForm();
      }),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextInputField(
                      controller: _firstNameController,
                      validator: Validator.validateName,
                      labelText: "First Name:",
                    ))),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextInputField(
                controller: _lastNameController,
                validator: Validator.validateName,
                labelText: "Last Name:",
              ),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextInputField(
            controller: _emailController,
            validator: Validator.validateEmail,
            labelText: "E-mail:",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextInputField(
            controller: _phoneNumberController,
            validator: Validator.validatePhoneNumber,
            labelText: "Phone number:",
            keyboardType: TextInputType.phone,
          ),
        )
      ]),
    );
  }

  void _onDonePressed(UserState state) {
    BlocProvider.of<UserBloc>(context).add(UpdateUser(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        username: state.user.username,
        phoneNumber: state.user.phoneNumber));
  }

  bool _validateForm() {
    return Validator.validateName(_firstNameController.text) == null &&
        Validator.validateName(_lastNameController.text) == null &&
        Validator.validateEmail(_emailController.text) == null &&
        Validator.validatePhoneNumber(_phoneNumberController.text) == null;
  }
}
