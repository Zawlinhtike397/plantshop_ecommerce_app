import 'package:flutter/material.dart';

class RegisterNowText extends StatelessWidget {
  const RegisterNowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {},
          child: Text(
            'Register Now',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
