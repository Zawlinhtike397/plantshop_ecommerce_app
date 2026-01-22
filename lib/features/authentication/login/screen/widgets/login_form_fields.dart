import 'package:flutter/material.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              // controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email must not be empty';
                }
                return null;
              },
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              // obscureText: _isPasswordVisible,
              // controller: _passwordController,
              decoration: InputDecoration(
                // suffixIcon: _passwordController.text.isNotEmpty
                //     ? IconButton(
                //         onPressed: () {
                //           setState(() {
                //             _isPasswordVisible = !_isPasswordVisible;
                //           });
                //         },
                //         icon: Icon(
                //           _isPasswordVisible
                //               ? Icons.visibility
                //               : Icons.visibility_off,
                //           color: Colors.grey,
                //         ),
                //       )
                //     : null,
                hintText: 'Enter your password',
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password must not be empty';
                }
                return null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
