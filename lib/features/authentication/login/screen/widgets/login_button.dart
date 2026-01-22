import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          'Login',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        onPressed: () async {
          // if (_formKey.currentState!.validate()) {}
        },
      ),
    );
  }
}
