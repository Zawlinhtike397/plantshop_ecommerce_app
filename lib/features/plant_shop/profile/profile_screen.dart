import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/common/widgets/image/rounded_image.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/widgets/profile_tile.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyAccount',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20.0,
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 12.0,
                    children: [
                      AppRoundedImage(
                        width: 72,
                        height: 72,
                        imageUrl: ImageStrings.profile1,
                      ),
                      Column(
                        spacing: 3,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shyvana',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Shyvana@gmail.com',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Iconsax.edit)),
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
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.discount_shape,
                        text: 'Discount Offers',
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.location,
                        text: 'My Addresses',
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.heart,
                        text: 'Favourites',
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.shopping_bag,
                        text: 'My Shopping Cart',
                        onTap: () {},
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
                        icon: Iconsax.moon,
                        text: 'Dark Mode',
                        onTap: () {},
                        trailingWidget: SizedBox(
                          height: 20,
                          child: Switch(value: true, onChanged: (value) {}),
                        ),
                      ),
                      ProfileTile(
                        icon: Iconsax.notification,
                        text: 'Notifications',
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.note,
                        text: 'Terms and conditions',
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Iconsax.message_programming,
                        text: 'FAQ',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
