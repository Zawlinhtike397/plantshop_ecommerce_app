import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/listView/address_listview.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/screen/add_address_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? selectedAddressId;

  @override
  void initState() {
    super.initState();

    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      context.read<AddressBloc>().add(FetchAddresses(user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddAddressScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              if (state is AddressLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AddressError) {
                return Center(child: Text(state.message));
              }

              if (state is AddressLoaded) {
                final addresses = state.addresses;

                if (selectedAddressId == null && addresses.isNotEmpty) {
                  selectedAddressId = addresses
                      .firstWhere(
                        (a) => a.isDefault,
                        orElse: () => addresses.first,
                      )
                      .id;
                }
                return AddressListview(
                  addresses: addresses,
                  selectedId: selectedAddressId,
                  onSelected: (id) {
                    setState(() {
                      selectedAddressId = id;
                    });
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
