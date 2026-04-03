import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/popups/fullscreen_loader.dart';
import 'package:plantify_plantshop_project/utils/validator/validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController homeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    homeController.dispose();
    streetController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        throw 'User not found';
      }
      final address = AddressModel(
        userId: user.id,
        contactName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        homeNo: homeController.text.trim(),
        street: streetController.text.trim(),
        city: cityController.text.trim(),
      );

      context.read<AddressBloc>().add(AddAddress(address));
    }
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String hint,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
            validator: validator,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressLoading) {
          FullscreenLoader.showLoader(context, text: 'Adding new address');
        } else if (state is AddressLoaded) {
          FullscreenLoader.hide(context);
          Navigator.pop(context);
        } else if (state is AddressError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Address',
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
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 15.0,
                children: [
                  _buildField(
                    context,
                    label: 'Contact Name',
                    controller: nameController,
                    hint: 'Enter name (eg, Home)',
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Contact Name'),
                  ),
                  _buildField(
                    context,
                    label: 'Contact Ph No',
                    controller: phoneController,
                    hint: 'Add phone number',
                    validator: (value) => Validator.validatePhoneNumber(value),
                  ),
                  _buildField(
                    context,
                    label: 'Home No',
                    controller: homeController,
                    hint: 'Enter home number',
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Home Number'),
                  ),
                  _buildField(
                    context,
                    label: 'Street No',
                    controller: streetController,
                    hint: 'Enter street number',
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Street Number'),
                  ),
                  _buildField(
                    context,
                    label: 'City',
                    controller: cityController,
                    hint: 'Enter city',
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'City name'),
                  ),

                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Add Address'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
