import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  static const _onboardingKey = 'onboarding_completed';
  static const _tokenKey = 'auth_token';

  final _supabase = Supabase.instance.client;

  Future<SharedPreferences> initSharedPerf() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await initSharedPerf();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await initSharedPerf();
    return prefs.getString(_tokenKey) != null;
  }

  Future<void> completeOnboarding() async {
    final prefs = await initSharedPerf();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<void> saveToken(String token) async {
    final prefs = await initSharedPerf();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final session = response.session;
      if (session == null) {
        throw Exception('Login failed');
      }

      await saveToken(session.accessToken);
    } catch (e) {
      print(e);
      throw ('Unexpected error: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> signInWithGoogle() async {
    var webClientId = dotenv.env['WEB_CLIENT_ID'];
    var androidClientId = dotenv.env['ANDROID_CLIENT_ID'];
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
      clientId: androidClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) throw 'No ID Token found.';

    final response = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      // accessToken: accessToken,
    );

    final session = response.session;
    if (session != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, session.accessToken);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'phone': phone},
        emailRedirectTo: 'com.plantify.app://login-callback',
      );

      final user = res.user;

      if (user == null) {
        throw Exception('Registration failed');
      }
    } catch (e) {
      throw Exception('Register error: $e');
    }
  }
}
