import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/features/common/auth/login/login_screen.dart';
import 'package:pizza_app/features/common/auth/register/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Image.asset("assets/logo3.png"),
            ),
            Padding(
                padding: const EdgeInsets.all(32).copyWith(bottom: 0),
                child: _googleButton(context)),
            _normalButtonSection(context),
          ],
        ),
      ),
    );
  }

  Widget _googleButton(BuildContext context) {
    return const DefaultButton(
      color: AppColors.white,
      text: "Sign Up with Google",
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: AppColors.primary,
      ),
      // onPressed: () => BlocProvider.of<AuthBloc>(context).add(LogIn()),
    );
  }

  Widget _normalButtonSection(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DefaultButton(
                text: "Register New Account",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ));
                },
              ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: <TextSpan>[
                  const TextSpan(
                    text: "Already have an account?",
                  ),
                  TextSpan(
                    text: " Login!",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}