import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/image/rounded_image.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/FAQ/faq_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/TermsAndConditions/terms_and_conditions_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/screen/address_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/cart_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/discount_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/favourite_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/order/order_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/profile_detail_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/widgets/profile_tile.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';
import 'package:plantify_plantshop_project/utils/popups/shimmer_effect.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      switch (state) {
                        case UserInitial():
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 3,
                            children: const [
                              ZShimmerEffect(width: 120, height: 16, radius: 4),
                              ZShimmerEffect(width: 160, height: 14, radius: 4),
                            ],
                          );

                        case UserLoaded(:final user):
                          final profileUrl =
                              user.profilePicture != null &&
                                  user.profilePicture!.isNotEmpty == true
                              ? user.profilePicture!
                              : ImageStrings.profile1;
                          return Row(
                            spacing: 12.0,
                            children: [
                              AppRoundedImage(
                                width: 60,
                                height: 60,
                                imageUrl: profileUrl,
                                isNetworkImage: profileUrl.startsWith('http'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 3,
                                children: [
                                  Text(
                                    user.userName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                  Text(
                                    user.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          );

                        case UserError():
                        case UserLoggedOut():
                          return const Text("Problem in Loading User Data...");
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileDetailScreen();
                          },
                        ),
                      );
                    },
                    icon: Icon(Iconsax.edit),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 22.0,
                children: [
                  HeadingWidget(name: 'Shopping'),
                  Column(
                    spacing: 10.0,
                    children: [
                      ProfileTile(
                        icon: Iconsax.shop,
                        text: 'My Orders',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return MyOrdersScreen();
                              },
                            ),
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Iconsax.discount_shape,
                        text: 'Discount Offers',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DiscountScreen();
                              },
                            ),
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Iconsax.location,
                        text: 'My Addresses',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AddressScreen();
                              },
                            ),
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Iconsax.heart,
                        text: 'Favourites',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return FavouriteScreen();
                              },
                            ),
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Iconsax.shopping_bag,
                        text: 'My Shopping Cart',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CartScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 22.0,
                children: [
                  HeadingWidget(name: 'Account Settings'),
                  Column(
                    spacing: 10.0,
                    children: [
                      ProfileTile(
                        icon: Iconsax.note,
                        text: 'Terms and conditions',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Iconsax.message_programming,
                        text: 'FAQ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FAQScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutUser());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
