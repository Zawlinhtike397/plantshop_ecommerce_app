import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/login_screen.dart';
import 'package:plantify_plantshop_project/features/authentication/onboarding/onboarding_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/widgets/bottom_navigation_menu.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:plantify_plantshop_project/utils/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (!state.hasInternet) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No Internet Connection'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            switch (state) {
              case AppInitial():
                return const SizedBox();
              case AppOnboarding():
                FlutterNativeSplash.remove();
                return const OnboardingScreen();
              case AppUnauthenticated():
                FlutterNativeSplash.remove();
                return const LoginScreen();
              case AppAuthenticated():
                FlutterNativeSplash.remove();
                return const BottomNavigationMenu();
            }
          },
        ),
      ),
    );
  }
}
