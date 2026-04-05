import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/image/rounded_image.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/authentication/login/screen/login_screen.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/change_profile_field.dart';
import 'package:plantify_plantshop_project/features/plant_shop/profile/widgets/profile_menu.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseUser = Supabase.instance.client.auth.currentUser;
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state is UserLoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Profile',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 17.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            switch (state) {
              case UserInitial():
                return const Center(child: CircularProgressIndicator());
              case UserLoaded(:final user):
                final profileUrl =
                    user.profilePicture != null &&
                        user.profilePicture!.isNotEmpty == true
                    ? user.profilePicture!
                    : ImageStrings.profile1;
                final formattedDate = user.createdAt != null
                    ? DateFormat('dd MMM, yyyy').format(user.createdAt!)
                    : '-';
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              AppRoundedImage(
                                width: 89,
                                height: 89,
                                imageUrl: profileUrl,
                                isNetworkImage: profileUrl.startsWith('http'),
                              ),
                              SizedBox(height: 7),
                              TextButton(
                                onPressed: () {
                                  context.read<UserBloc>().add(
                                    UpdateProfilePicture(),
                                  );
                                },
                                child: const Text(
                                  'Change Profile Picture',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(),
                        const SizedBox(height: 16.0),
                        const HeadingWidget(name: 'Profile Information'),
                        const SizedBox(height: 16.0),
                        ZProfileMenu(
                          title: 'Name',
                          value: user.userName,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeProfileFieldScreen(
                                    field: ProfileField.username,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ZProfileMenu(
                          title: 'Email',
                          value: user.email,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeProfileFieldScreen(
                                    field: ProfileField.email,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ZProfileMenu(
                          title: 'Phone No',
                          value: user.phoneNumber!,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeProfileFieldScreen(
                                    field: ProfileField.phoneNumber,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        ZProfileMenu(
                          title: 'Created at',
                          value: formattedDate,
                          onTap: null,
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );

              case UserError():
                final error = state;
                return Center(child: Text(error.message));

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
