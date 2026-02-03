import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/forgot_password_text_btn.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/form_divider.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_button.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/login_form_fields.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/register_now_text_btn.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/widgets/social_icon_buttons.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                AppText.loginFormHeader,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              LoginFormFields(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 10.0),
              ForgotPasswordTextBtn(),
              const SizedBox(height: 20.0),
              LoginButton(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 10.0),
              RegisterNowTextBtn(),
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
