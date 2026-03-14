import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plantify_plantshop_project/common/plant_info/repository/plant_repository.dart';
import 'package:plantify_plantshop_project/common/search/cubit/search_cubit.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/screen/app.dart';
import 'package:plantify_plantshop_project/features/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/plant_info/bloc/plant_bloc.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => PlantRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PlantBloc(plantRepository: context.read<PlantRepository>()),
          ),
          BlocProvider(
            create: (context) => AppBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              authRepository: context.read<AuthRepository>(),
              appBloc: context.read<AppBloc>(),
              userRepository: context.read<UserRepository>(),
            )..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(create: (_) => SearchCubit()),
          BlocProvider(create: (_) => NetworkBloc()..add(NetworkRequested())),
          BlocProvider(create: (_) => NavigationCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
