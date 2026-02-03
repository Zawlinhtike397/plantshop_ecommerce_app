import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/login/bloc/login_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      context.read<LoginBloc>().add(
                        LoginSubmitted(email, password),
                      );
                    }
                  },
            child: Text(AppText.login),
          ),
        );
      },
    );
  }
}
