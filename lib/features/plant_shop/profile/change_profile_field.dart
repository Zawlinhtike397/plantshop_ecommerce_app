import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';
import 'package:plantify_plantshop_project/utils/validator/validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeProfileFieldScreen extends StatefulWidget {
  final ProfileField field;
  const ChangeProfileFieldScreen({super.key, required this.field});

  @override
  State<ChangeProfileFieldScreen> createState() =>
      _ChangeProfileFieldScreenState();
}

class _ChangeProfileFieldScreenState extends State<ChangeProfileFieldScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  String _getdescriptionText() {
    switch (widget.field) {
      case ProfileField.username:
        return AppText.changeNameText;
      case ProfileField.email:
        return AppText.changeEmailText;
      case ProfileField.phoneNumber:
        return AppText.changePhoneNumberText;
    }
  }

  String get fieldName {
    switch (widget.field) {
      case ProfileField.username:
        return 'Username';
      case ProfileField.email:
        return 'Email';
      case ProfileField.phoneNumber:
        return 'Phone Number';
    }
  }

  String _getlabelText() {
    switch (widget.field) {
      case ProfileField.username:
        return AppText.name;
      case ProfileField.email:
        return AppText.email;
      case ProfileField.phoneNumber:
        return AppText.phoneNo;
    }
  }

  IconData _getcustomIcon() {
    switch (widget.field) {
      case ProfileField.username:
        return Iconsax.people;
      case ProfileField.email:
        return Iconsax.send;
      case ProfileField.phoneNumber:
        return Iconsax.call;
    }
  }

  String? _getValidator(String? value) {
    switch (widget.field) {
      case ProfileField.username:
        return Validator.validateIsEmpty(value, 'Username');
      case ProfileField.email:
        return Validator.validateEmail(value);
      case ProfileField.phoneNumber:
        return Validator.validatePhoneNumber(value);
    }
  }

  String get supabaseFieldName {
    switch (widget.field) {
      case ProfileField.username:
        return 'name';
      case ProfileField.email:
        return 'email';
      case ProfileField.phoneNumber:
        return 'phone_no';
    }
  }

  @override
  void initState() {
    super.initState();

    final userState = context.read<UserBloc>().state;

    if (userState is UserLoaded) {
      switch (widget.field) {
        case ProfileField.username:
          _controller.text = userState.user.userName;
          break;
        case ProfileField.email:
          _controller.text = userState.user.email;
          break;
        case ProfileField.phoneNumber:
          _controller.text = userState.user.phoneNumber ?? '';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change $fieldName',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 16.0,
          children: [
            Text(
              _getdescriptionText(),
              style: Theme.of(context).textTheme.labelMedium,
            ),

            Form(
              key: _formKey,
              child: Column(
                spacing: 16.0,
                children: [
                  TextFormField(
                    controller: _controller,
                    validator: (value) {
                      return _getValidator(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(_getcustomIcon()),
                      labelText: _getlabelText(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final value = _controller.text.trim();
                    if (widget.field == ProfileField.email) {
                      final supabaseUser =
                          Supabase.instance.client.auth.currentUser;

                      final providers =
                          supabaseUser?.appMetadata['providers']
                              as List<dynamic>? ??
                          [];

                      final hasOAuth = providers.any(
                        (provider) => provider != 'email',
                      );

                      if (hasOAuth) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Email cannot be changed because this account is linked with Google.',
                            ),
                          ),
                        );
                        return;
                      }

                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Change Email'),
                            content: Text(
                              'Changing your email will log you out.You will need to login again using the new email.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm != true) return;

                      await context.read<UserBloc>().authRepository.changeEmail(
                        value,
                      );

                      context.read<UserBloc>().add(LogoutUser());

                      Navigator.pop(context);
                      return;
                    }

                    context.read<UserBloc>().add(
                      UpdateUserField(field: supabaseFieldName, value: value),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
