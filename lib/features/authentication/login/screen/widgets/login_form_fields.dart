import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';
import 'package:plantify_plantshop_project/utils/validator/validation.dart';

class LoginFormFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.email,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.emailController,
              decoration: InputDecoration(hintText: AppText.emailHintText),
              validator: (value) => Validator.validateEmail(value),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.password,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: AppText.passwordHintText,
                suffixIcon: widget.passwordController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
              ),
              validator: (value) =>
                  Validator.validateIsEmpty(value, 'Password'),
            ),
          ],
        ),
      ],
    );
  }
}
