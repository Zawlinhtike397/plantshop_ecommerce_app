import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/plantify_logo.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _formKey = GlobalKey<FormState>();
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
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                PlantifyLogo(width: 300, height: 170),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width > 600
                      ? 600
                      : MediaQuery.sizeOf(context).width,
                  child: LoginForm(),
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
