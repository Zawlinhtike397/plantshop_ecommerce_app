import 'package:bloc/bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final CartRepository cartRepository;

  AppBloc({
    required this.authRepository,
    required this.userRepository,
    required this.cartRepository,
  }) : super(AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  Future<void> _handleAuthState(Emitter<AppState> emit) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final loggedIn = await authRepository.isLoggedIn();

    if (!loggedIn) {
      await cartRepository.clearCart();
      emit(AppUnauthenticated());
      return;
    }

    await userRepository.addOrUpdateUserData();

    final userId = Supabase.instance.client.auth.currentUser!.id;

    await cartRepository.initForUser(userId);

    emit(AppAuthenticated());
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    final onboarded = await authRepository.isOnboardingCompleted();

    if (!onboarded) {
      emit(AppOnboarding());
      return;
    }

    await _handleAuthState(emit);
  }

  Future<void> _onOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    await authRepository.completeOnboarding();

    await _handleAuthState(emit);
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    await _handleAuthState(emit);
  }
}
