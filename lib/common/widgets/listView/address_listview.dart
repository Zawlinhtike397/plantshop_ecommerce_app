import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/listTile/address_list_tile.dart';

class AddressListview extends StatefulWidget {
  const AddressListview({super.key});

  @override
  State<AddressListview> createState() => _AddressListviewState();
}

class _AddressListviewState extends State<AddressListview> {
  List<String> shippingOptions = [
    'Option1',
    'Option2',
    'Option3',
    'Option4',
    'Option5',
    'Option6',
    'Option7',
    'Option8',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shippingOptions.length,
      itemBuilder: (context, index) {
        return AddressListTile(index: index);
      },
    );
  }
}
