import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/screen/app.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AppBloc(context.read<AuthRepository>())..add(AppStarted()),
        child: const MyApp(),
      ),
    ),
  );
}
