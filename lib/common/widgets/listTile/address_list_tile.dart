import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/screen/edit_address_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class AddressListTile extends StatelessWidget {
  final int index;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final AddressModel address;

  const AddressListTile({
    super.key,
    required this.index,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.brightnessOf(context) == Brightness.dark
              ? AppColor.darkerGrey
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio.adaptive(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.contactName,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address.phone,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${address.homeNo}, ${address.street}, ${address.city}",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // const Spacer(),
            IconButton(
              icon: const Icon(Iconsax.trash),
              color: Theme.brightnessOf(context) == Brightness.dark
                  ? AppColor.white
                  : AppColor.darkerGrey,
              iconSize: 20,
              onPressed: () async {
                final confirm = await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Delete Address"),
                    content: const Text(
                      "Are you sure you want to delete this address?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );

                if (confirm == true && address.id != null) {
                  context.read<AddressBloc>().add(
                    DeleteAddress(address.id!, address.userId),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Iconsax.edit),
              color: Theme.brightnessOf(context) == Brightness.dark
                  ? AppColor.white
                  : AppColor.darkerGrey,
              iconSize: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditAddressScreen(address: address);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
