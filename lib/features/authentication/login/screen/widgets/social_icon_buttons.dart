import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/authentication/login/bloc/login_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class SocialIconButtons extends StatelessWidget {
  const SocialIconButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            try {} catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Facebook Sign-In Error: ${e.toString()}'),
                ),
              );
            }
          },
          child: Container(
            width: 90,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(image: AssetImage(ImageStrings.facebookLogo)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () async {
            context.read<LoginBloc>().add(GoogleLoginRequested());
          },
          child: Container(
            width: 90,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Image(image: AssetImage(ImageStrings.googleLogo)),
          ),
        ),
      ],
    );
  }
}
