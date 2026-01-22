import 'package:flutter/material.dart';

class ForgotPasswordTextBtn extends StatelessWidget {
  const ForgotPasswordTextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              "Forgot Password?",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
