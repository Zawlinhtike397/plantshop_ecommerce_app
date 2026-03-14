import 'package:bloc/bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AppBloc({required this.authRepository, required this.userRepository})
    : super(AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  Future<void> checkLoginStatus(Emitter<AppState> emit) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final loggedIn = await authRepository.isLoggedIn();
    if (loggedIn) {
      await userRepository.addOrUpdateUserData();
      emit(AppAuthenticated());
    } else {
      emit(AppUnauthenticated());
    }
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    final onboarded = await authRepository.isOnboardingCompleted();

    if (!onboarded) {
      emit(AppOnboarding());
      return;
    }

    await checkLoginStatus(emit);
  }

  Future<void> _onOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    await authRepository.completeOnboarding();

    await checkLoginStatus(emit);
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    await checkLoginStatus(emit);
  }
}
