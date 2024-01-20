import 'package:pizza_app/common/validator/validator.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/common/widgets/text_input_field.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/common/auth/login/bloc/auth_bloc.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key});

  static void showAsModalBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const ProfileSheet(),
        ),
      );

  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet> {
  final TextEditingController _controller = TextEditingController();
  bool enableButton = true;

  @override
  void initState() {
    _controller.text = "";
    enableButton = _controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 300,
      color: AppColors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 32),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              width: 30,
              height: 8,
            ),
            Spacer(),
            DefaultButton(
              text: "Sign Out",
              onPressed: () =>
                  {BlocProvider.of<AuthBloc>(context).add(SignOut())},
            ),
          ],
        ),
      ),
    );
  }
}
