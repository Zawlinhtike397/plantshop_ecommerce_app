import 'package:flutter/material.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            textAlign: TextAlign.center,
            'Or Login with',
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: const Color(0xff6A707C)),
          ),
        ),
        const Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
      ],
    );
  }
}
