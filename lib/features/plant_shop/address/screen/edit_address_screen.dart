import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/bloc/address_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/address/model/address_model.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/popups/fullscreen_loader.dart';
import 'package:plantify_plantshop_project/utils/validator/validation.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressModel address;

  const EditAddressScreen({super.key, required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController homeController;
  late TextEditingController streetController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.address.contactName);
    phoneController = TextEditingController(text: widget.address.phone);
    homeController = TextEditingController(text: widget.address.homeNo);
    streetController = TextEditingController(text: widget.address.street);
    cityController = TextEditingController(text: widget.address.city);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    homeController.dispose();
    streetController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _updateAddress() {
    if (_formKey.currentState!.validate()) {
      final updatedAddress = widget.address.copyWith(
        contactName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        homeNo: homeController.text.trim(),
        street: streetController.text.trim(),
        city: cityController.text.trim(),
      );

      context.read<AddressBloc>().add(UpdateAddress(updatedAddress));
    }
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(hintText: 'Enter $label'),
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
          FullscreenLoader.showLoader(context, text: 'Updating the address');
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
            'Edit Address',
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
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Contact Name'),
                  ),
                  _buildField(
                    context,
                    label: 'Contact Ph No',
                    controller: phoneController,
                    validator: (value) => Validator.validatePhoneNumber(value),
                  ),
                  _buildField(
                    context,
                    label: 'Home No',
                    controller: homeController,
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Home Number'),
                  ),
                  _buildField(
                    context,
                    label: 'Street No',
                    controller: streetController,
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'Street Number'),
                  ),
                  _buildField(
                    context,
                    label: 'City',
                    controller: cityController,
                    validator: (value) =>
                        Validator.validateIsEmpty(value, 'City name'),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateAddress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Edit Address'),
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
