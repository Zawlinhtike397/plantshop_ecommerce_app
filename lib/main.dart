import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:plantify_plantshop_project/data/repositories/address_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/order_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/plant_repository.dart';
import 'package:plantify_plantshop_project/common/search/cubit/search_cubit.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/app/screen/app.dart';
import 'package:plantify_plantshop_project/features/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/bloc/checkout_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/bloc/favourites_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/favourite_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/bloc/order_bloc.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'common/plant_info/bloc/plant_bloc.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(AppliedCouponModelAdapter());

  await Hive.openBox<CartItemModel>('cartBox');
  await Hive.openBox<AppliedCouponModel>('couponBox');

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
        RepositoryProvider(create: (_) => FavouriteRepository()),
        RepositoryProvider(create: (_) => CartRepository()),
        RepositoryProvider(create: (_) => DiscountRepository()),
        RepositoryProvider(create: (_) => AddressRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PlantBloc(
              plantRepository: context.read<PlantRepository>(),
              // ..add(LoadPlantsEvent()),
            ),
          ),
          BlocProvider(
            create: (context) =>
                FavouritesBloc(repository: context.read<FavouriteRepository>())
                  ..add(LoadFavouritesEvent()),
          ),
          BlocProvider(
            create: (context) => DiscountBloc(
              discountRepository: context.read<DiscountRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => AddressBloc(
              addressRepository: context.read<AddressRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CheckoutBloc(
              orderRepository: context.read<OrderRepository>(),
              discountRepository: context.read<DiscountRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                OrderBloc(orderRepository: context.read<OrderRepository>()),
            // ..add(FetchOrders()),
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
            create: (context) =>
                CartBloc(cartRepository: context.read<CartRepository>())
                  ..add(LoadCartEvent()),
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
