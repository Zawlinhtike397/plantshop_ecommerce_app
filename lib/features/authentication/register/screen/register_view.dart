import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/plantify_logo.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/widgets/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight),
                PlantifyLogo(width: 400, height: 250),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width > 600
                      ? 600
                      : MediaQuery.sizeOf(context).width,
                  child: RegisterForm(),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
