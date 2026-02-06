import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/cart_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/favourite_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/home_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/profile_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            elevation: 0,
            selectedIndex: selectedIndex,
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            indicatorColor: isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.1),

            destinations: [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                selectedIcon: Icon(Iconsax.home, color: AppColor.buttonPrimary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.shop),
                selectedIcon: Icon(Iconsax.shop, color: AppColor.buttonPrimary),
                label: 'Store',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.heart),
                selectedIcon: Icon(
                  Iconsax.heart,
                  color: AppColor.buttonPrimary,
                ),
                label: 'Wishlist',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.user),
                selectedIcon: Icon(Iconsax.user, color: AppColor.buttonPrimary),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (index) {
              context.read<NavigationCubit>().changeIndex(index);
            },
          ),
          body: _screens[selectedIndex],
        );
      },
    );
  }
}

const List<Widget> _screens = [
  HomeScreen(),
  FavouriteScreen(),
  CartScreen(),
  ProfileScreen(),
];
