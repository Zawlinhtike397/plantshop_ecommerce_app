import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/forgot_password/reset_password_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  sendResetPasswordMail() {
    context.read<ForgotPasswordBloc>().add(
      SendResetEmail(_emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        switch (state) {
          case ResetLinkVerified():
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
            );

          case ResetEmailSent():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset link sent to your email!'),
              ),
            );

          case ForgotPasswordError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );

          default:
            break;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    ImageStrings.forgotPwBackground,
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height < 670
                        ? 280
                        : MediaQuery.sizeOf(context).height * 0.475,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor, width: 1),
                  ),
                  child: Icon(
                    Icons.lock,
                    size: 30,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Forgot Password?',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontSize: 22.0),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                    'Input your email address below so that we can send the password reset link.',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width > 500
                              ? 500
                              : MediaQuery.sizeOf(context).width,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: Colors.grey, fontSize: 16),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColor.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: AppColor.borderColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width > 500
                        ? 500
                        : MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        backgroundColor: AppColor.buttonPrimary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendResetPasswordMail();
                        }
                      },
                      child: Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
