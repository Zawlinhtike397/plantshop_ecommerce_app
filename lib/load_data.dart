import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/widgets/profile_tile.dart';
import 'package:plantify_plantshop_project/utils/popups/fullscreen_loader.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PlantBloc, PlantState>(
          listener: (context, state) {
            if (state is PlantUploading) {
              FullscreenLoader.showLoader(context, text: "Uploading plants...");
            }

            if (state is PlantUploaded) {
              FullscreenLoader.hide(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Upload Success")));
            }

            if (state is PlantError) {
              FullscreenLoader.hide(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is DiscountUploading) {
              FullscreenLoader.showLoader(
                context,
                text: "Uploading discounts...",
              );
            }

            if (state is DiscountUploaded) {
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Discount Upload Success")),
              );
            }

            if (state is DiscountError) {
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressLoading) {
              FullscreenLoader.showLoader(
                context,
                text: "Uploading addresses...",
              );
            }

            if (state is AddressUploaded) {
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Address Upload Success")),
              );
            }

            if (state is AddressError) {
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Scaffold(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const HeadingWidget(name: 'Main Record'),
                const SizedBox(height: 16.0),
                ProfileTile(
                  icon: Iconsax.shop,
                  text: 'Load Plant Data',
                  onTap: () {
                    context.read<PlantBloc>().add(UploadPlantDataEvent());
                  },
                ),
                ProfileTile(
                  icon: Iconsax.discount_shape,
                  text: 'Load Discount Data',
                  onTap: () {
                    context.read<DiscountBloc>().add(UploadDiscounts());
                  },
                ),
                ProfileTile(
                  icon: Iconsax.location,
                  text: 'Load Address Data',
                  onTap: () {
                    context.read<AddressBloc>().add(UploadAddressData());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
