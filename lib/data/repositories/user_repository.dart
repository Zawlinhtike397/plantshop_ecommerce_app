import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:plantify_plantshop_project/common/user/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final _supabase = Supabase.instance.client;

  User? get user {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception("No logged in user");
    }
    return currentUser;
  }

  Future<UserModel> fetchCurrentUser() async {
    await syncEmailWithAuth();

    final data = await _supabase
        .from('Users')
        .select('user_id,name,email,phone_no,profile_picture,created_at')
        .eq('user_id', user!.id)
        .single();

    return UserModel.fromJson(data);
  }

  Future<void> updateProfile(UserModel user) async {
    await _supabase.from('Users').update(user.toJson()).eq('id', user.id);
  }

  Future<void> addOrUpdateUserData() async {
    final metadata = user!.userMetadata ?? {};
    final name = metadata['name'] ?? metadata['full_name'] ?? '';
    final phone = metadata['phone'] ?? '';
    final profilePicture = metadata['avatar_url'] ?? '';

    final existingUser = await _supabase
        .from('Users')
        .select()
        .eq('user_id', user!.id)
        .maybeSingle();

    if (existingUser == null) {
      await _supabase.from('Users').upsert({
        'user_id': user!.id,
        'email': user!.email,
        'name': name,
        'phone_no': phone,
        'profile_picture': profilePicture,
        'created_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id');
      return;
    }

    final Map<String, dynamic> updates = {};

    if ((existingUser['name'] == null || existingUser['name'] == '') &&
        name != null) {
      updates['name'] = name;
    }

    if ((existingUser['phone_no'] == null || existingUser['phone_no'] == '') &&
        phone != null) {
      updates['phone_no'] = phone;
    }

    if ((existingUser['profile_picture'] == null ||
            existingUser['profile_picture'] == '') &&
        profilePicture != null &&
        profilePicture.isNotEmpty) {
      updates['profile_picture'] = profilePicture;
    }

    if (updates.isNotEmpty) {
      await _supabase.from('Users').update(updates).eq('user_id', user!.id);
    }
  }

  Future<UserModel> updateSingleField({
    required String field,
    required dynamic value,
  }) async {
    await _supabase
        .from('Users')
        .update({field: value})
        .eq('user_id', user!.id);

    final updatedData = await _supabase
        .from('Users')
        .select('user_id,name,email,phone_no,profile_picture,created_at')
        .eq('user_id', user!.id)
        .single();

    return UserModel.fromJson(updatedData);
  }

  Future<void> syncEmailWithAuth() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) return;

    final dbUser = await _supabase
        .from('Users')
        .select('email')
        .eq('user_id', authUser.id)
        .single();

    final dbEmail = dbUser['email'];

    if (dbEmail != authUser.email) {
      await _supabase
          .from('Users')
          .update({'email': authUser.email})
          .eq('user_id', authUser.id);
    }
  }

  Future<UserModel> updateProfilePicture() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      throw Exception("No image selected");
    }

    final file = File(image.path);
    final fileExt = image.path.split('.').last;
    final fileName = '${user!.id}.$fileExt';

    await _supabase.storage
        .from('profile_picture')
        .upload(
          'users/$fileName',
          file,
          fileOptions: const FileOptions(upsert: true),
        );

    final imageUrl = _supabase.storage
        .from('profile_picture')
        .getPublicUrl('users/$fileName');

    await _supabase
        .from('Users')
        .update({'profile_picture': imageUrl})
        .eq('user_id', user!.id);

    final updatedData = await _supabase
        .from('Users')
        .select('user_id,name,email,phone_no,profile_picture,created_at')
        .eq('user_id', user!.id)
        .single();

    return UserModel.fromJson(updatedData);
  }
}
