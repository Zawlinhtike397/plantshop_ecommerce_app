import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/edit_address_screen.dart';

class AddressListTile extends StatefulWidget {
  final int index;
  const AddressListTile({super.key, required this.index});

  @override
  State<AddressListTile> createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {
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
  late String _selectedShippingOption;

  List<String> placeDescriptions = [
    'Home',
    'Work',
    'Gym',
    'School',
    'Va',
    'CJ',
    'Ek',
    'Bm',
  ];
  List<String> phoneNumbers = [
    '09232324421',
    '09876543210',
    '09232324421',
    '09876543210',
    '092323232323',
    '09876543210',
    '09232324421',
    '09876543210',
  ];
  List<String> addresses = [
    'Yangon, Shwe Pyi Thar',
    'Mandalay, Chan Aye Thar Zan',
    'Yangon, Hlaing Thar Yar',
    'Mandalay, Taw Win',
    'Mandalay, Chan Ko',
    'Yangon, Bahan',
    'Mandalay, Nan Shae',
    'Kachin, Myit Kyi Na',
  ];

  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> placeDescriptionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> addressControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedShippingOption = shippingOptions[0];

    // for (int i = 0; i < shippingOptions.length; i++) {
    //   placeDescriptionControllers[i].text = placeDescriptions[i];
    //   phoneNumberControllers[i].text = phoneNumbers[i];
    //   addressControllers[i].text = addresses[i];
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio.adaptive(
              value: shippingOptions[widget.index],
              groupValue: _selectedShippingOption,
              onChanged: (value) {
                setState(() {
                  _selectedShippingOption = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeDescriptions[widget.index],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phoneNumbers[widget.index],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    addresses[widget.index],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      // fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Iconsax.edit),
              color: Colors.black,
              iconSize: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditAddressScreen();
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
