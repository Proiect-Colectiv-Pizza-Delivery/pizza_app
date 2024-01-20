import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/native_dialog.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/features/user/profile/user_bloc.dart/user_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isButtonEnabled = true;
  bool mustListen = false;

  File? _profilePicture;
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
    return BlocConsumer<UserBloc, UserState>(
        listener: (context, state){
          if(state is UserLoaded && mustListen == true){
            NativeDialog(
                title: "Changes Saved",
                content: "Your profile info was updated",
                firstButtonText: "Ok")
                .showOSDialog(context);
            setState(() {
              mustListen = false;
            });
          }
        },
      builder: (context, state) => RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Signed in as: ${state.user.userName}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              _profilePicturePicker(),
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
          ),
        ),
      ),
    );
  }

  void _setFields(User user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneNumberController.text = user.phoneNumber;

    setState(() {
      _profilePicture = user.profilePicture;
    });
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _profilePicture = File(pickedImage.path);
      }
    });
  }

  Widget _profilePicturePicker() {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: GestureDetector(
          onTap: _getImageFromGallery,
          child: CircleAvatar(
            radius: 120,
            backgroundColor: Colors.grey[300],
            child: _profilePicture != null
                ? ClipOval(
                    child: Image.file(
                      _profilePicture!,
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.camera_alt,
                    size: 60,
                    color: Colors.grey[600],
                  ),
          ),
        ));
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
        username: state.user.userName,
        phoneNumber: state.user.phoneNumber,
        profilePicture: _profilePicture));
    setState(() {
      mustListen = true;
    });
  }

  bool _validateForm() {
    return Validator.validateName(_firstNameController.text) == null &&
        Validator.validateName(_lastNameController.text) == null &&
        Validator.validateEmail(_emailController.text) == null &&
        Validator.validatePhoneNumber(_phoneNumberController.text) == null;
  }
}
