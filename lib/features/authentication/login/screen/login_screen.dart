import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/login/bloc/login_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/login_view.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:plantify_plantshop_project/utils/popups/fullscreen_loader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        networkBloc: context.read<NetworkBloc>(),
        authRepository: context.read<AuthRepository>(),
        appBloc: context.read<AppBloc>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginInitial():
              FullscreenLoader.hide(context);
              break;
            case LoginLoading():
              FullscreenLoader.showLoader(context, text: 'Signing you in...');
              break;
            case LoginSuccess():
              FullscreenLoader.hide(context);
              break;
            case LoginFailure(message: final message):
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              break;
          }
        },
        child: LoginView(),
      ),
    );
  }
}
