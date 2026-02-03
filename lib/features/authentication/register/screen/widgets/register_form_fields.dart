import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';
import 'package:plantify_plantshop_project/utils/validator/validation.dart';

class RegisterFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPwController;
  final TextEditingController phNoController;

  const RegisterFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPwController,
    required this.phNoController,
    required this.nameController,
  });

  @override
  State<RegisterFormFields> createState() => _RegisterFormFieldsState();
}

class _RegisterFormFieldsState extends State<RegisterFormFields> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.nameController,
              decoration: InputDecoration(hintText: AppText.nameHintText),
              validator: (value) =>
                  Validator.validateIsEmpty(value, 'UserName'),
            ),
          ],
        ),
        SizedBox(height: 15.0),
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
              AppText.phoneNo,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.phNoController,
              decoration: InputDecoration(hintText: AppText.phoneNoHintText),
              validator: (value) => Validator.validatePhoneNumber(value),
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
              onChanged: (value) {
                setState(() {});
              },
              obscureText: _obscurePassword,
              controller: widget.passwordController,
              decoration: InputDecoration(
                suffixIcon: widget.passwordController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                hintText: AppText.passwordHintText,
              ),
              validator: (value) => Validator.validatePassword(value),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.confirmPassword,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              obscureText: _obscureConfirmPassword,
              controller: widget.confirmPwController,
              decoration: InputDecoration(
                suffixIcon: widget.confirmPwController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                hintText: AppText.confirmPasswordHintText,
              ),
              validator: (value) {
                if (value == widget.passwordController.text) {
                  Validator.validatePassword(value);
                } else {
                  return 'password does not match';
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
