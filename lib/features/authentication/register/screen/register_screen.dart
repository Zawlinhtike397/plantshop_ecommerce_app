import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/login_screen.dart';
import 'package:plantify_plantshop_project/features/authentication/register/bloc/register_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/register/screen/register_view.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:plantify_plantshop_project/utils/popups/fullscreen_loader.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterBloc(
        networkBloc: context.read<NetworkBloc>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          switch (state) {
            case RegisterInitial():
              FullscreenLoader.hide(context);
              break;
            case RegisterLoading():
              FullscreenLoader.showLoader(context, text: 'Registering user...');
              break;
            case RegisterEmailVerificationSent():
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Verification email sent! Please check your inbox 📧',
                  ),
                ),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              break;
            case RegisterSuccess():
              FullscreenLoader.hide(context);
              break;
            case RegisterFailure(message: final message):
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              break;
          }
        },
        child: RegisterView(),
      ),
    );
  }
}
