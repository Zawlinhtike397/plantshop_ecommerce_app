import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/plantify_logo.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool _isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
                  child: LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
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
