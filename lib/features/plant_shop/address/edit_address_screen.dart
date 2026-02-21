import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Form(
          child: Column(
            spacing: 15.0,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Name',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: widget.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter name(eg, Home)',
                    ),
                    // validator: (value) =>
                    //     Validator.validateIsEmpty(value, 'UserName'),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // AppText.email,
                    'Contact Ph No',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: widget.emailController,
                    decoration: InputDecoration(
                      hintText: 'Add Phone No to contact that place',
                    ),
                    // validator: (value) => Validator.validateEmail(value),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // AppText.email,
                    'Home No',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: widget.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your home number',
                    ),
                    // validator: (value) => Validator.validateEmail(value),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // AppText.email,
                    'Street No',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: widget.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your street number',
                    ),
                    // validator: (value) => Validator.validateEmail(value),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // AppText.email,
                    'City',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: widget.emailController,
                    decoration: InputDecoration(hintText: 'Enter your city'),
                    // validator: (value) => Validator.validateEmail(value),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                  child: const Text('Edit Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
