import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/listTile/address_list_tile.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressListview extends StatefulWidget {
  final List<AddressModel> addresses;
  final String? selectedId;
  final Function(String id)? onSelected;

  const AddressListview({
    super.key,
    this.onSelected,
    required this.addresses,
    this.selectedId,
  });

  @override
  State<AddressListview> createState() => _AddressListviewState();
}

class _AddressListviewState extends State<AddressListview> {
  @override
  Widget build(BuildContext context) {
    final addresses = widget.addresses;

    if (addresses.isEmpty) {
      return const Center(child: Text("No addresses found"));
    }

    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];

        return AddressListTile(
          index: index,
          value: address.id ?? '',
          groupValue: widget.selectedId ?? '',
          address: address,
          onChanged: (value) {
            if (value != null) {
              widget.onSelected?.call(value);

              final user = Supabase.instance.client.auth.currentUser;

              if (user != null) {
                context.read<AddressBloc>().add(
                  SetDefaultAddress(user.id, value),
                );
              }
            }
          },
        );
      },
    );
  }
}
