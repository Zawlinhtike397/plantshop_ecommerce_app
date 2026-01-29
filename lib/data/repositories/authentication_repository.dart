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
    const webClientId =
        '97248628227-38kvb23ft7ak9pcoadvp0mj56of240v2.apps.googleusercontent.com';
    const androidClientId =
        '97248628227-1hnm1clm2r6invovs04op4o54mj8crgp.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
      clientId: androidClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = await googleUser.authentication;
    // final accessToken = googleAuth.;
    final idToken = googleAuth.idToken;

    // if (accessToken == null) throw 'No Access Token found.';
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
}
