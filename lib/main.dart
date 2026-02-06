import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/screen/app.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      providers: [RepositoryProvider(create: (_) => AuthRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkBloc()..add(NetworkRequested())),
          BlocProvider(
            create: (context) =>
                AppBloc(context.read<AuthRepository>())..add(AppStarted()),
          ),
          BlocProvider(create: (context) => NavigationCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
