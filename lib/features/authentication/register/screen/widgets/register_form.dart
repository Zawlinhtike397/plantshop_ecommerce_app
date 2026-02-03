import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/widgets/login_now_text_btn.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/widgets/register_button.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/widgets/register_form_fields.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPwController = TextEditingController();
    final TextEditingController phNoController = TextEditingController();

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
                AppText.registerFormHeader,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),

              RegisterFormFields(
                emailController: emailController,
                passwordController: passwordController,
                confirmPwController: confirmPwController,
                phNoController: phNoController,
                nameController: nameController,
              ),
              const SizedBox(height: 30.0),

              RegisterButton(
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPwController: confirmPwController,
                phNoController: phNoController,
              ),
              const SizedBox(height: 10.0),

              LoginNowTextBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
