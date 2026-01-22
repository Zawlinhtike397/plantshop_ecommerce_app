import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/forgot_password_text_btn.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/form_divider.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_button.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_form_fields.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/register_now_text.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/social_icon_buttons.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // key: _formKey,
          child: Column(
            children: [
              Text(
                'Login to your account',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 15.0),
              LoginFormFields(),
              const SizedBox(height: 10.0),
              ForgotPasswordTextBtn(),
              const SizedBox(height: 10.0),
              LoginButton(),
              const SizedBox(height: 10.0),
              RegisterNowText(),
              const SizedBox(height: 10.0),
              FormDivider(),
              const SizedBox(height: 15),
              SocialIconButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
