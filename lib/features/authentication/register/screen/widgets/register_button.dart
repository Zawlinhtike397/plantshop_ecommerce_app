import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/register/bloc/register_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPwController;
  final TextEditingController phNoController;

  const RegisterButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPwController,
    required this.phNoController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        child: Text(AppText.register),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<RegisterBloc>().add(
              RegisterRequested(
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                phone: phNoController.text.trim(),
              ),
            );
          }
        },
      ),
    );
  }
}
