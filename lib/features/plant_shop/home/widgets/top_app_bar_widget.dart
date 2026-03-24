import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';
import 'package:plantify_plantshop_project/common/widgets/image/rounded_image.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';
import 'package:plantify_plantshop_project/utils/constants/text_strings.dart';
import 'package:plantify_plantshop_project/utils/popups/shimmer_effect.dart';

class TopAppBarWidget extends StatelessWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12.0,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                switch (state) {
                  case UserLoaded(:final user):
                    final profileUrl =
                        user.profilePicture != null &&
                            user.profilePicture!.isNotEmpty == true
                        ? user.profilePicture!
                        : ImageStrings.profile1;
                    return AppRoundedImage(
                      width: 65,
                      height: 65,
                      imageUrl: profileUrl,
                      isNetworkImage: profileUrl.startsWith('http'),
                    );

                  default:
                    return AppRoundedImage(
                      width: 52,
                      height: 52,
                      imageUrl: ImageStrings.profile1,
                    );
                }
              },
            ),
            Column(
              spacing: 3.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.welcomeText,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    switch (state) {
                      case UserLoaded(:final user):
                        return Text(
                          user.userName,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      case UserInitial():
                        return const ZShimmerEffect(
                          width: 100,
                          height: 20,
                          radius: 6,
                        );
                      case UserError():
                      case UserLoggedOut():
                        return Text(
                          'User',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                    }
                  },
                ),
              ],
            ),
          ],
        ),

        CartIconBtnWidget(),
      ],
    );
  }
}
