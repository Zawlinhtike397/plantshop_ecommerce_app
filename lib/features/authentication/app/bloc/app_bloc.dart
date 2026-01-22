import 'package:bloc/bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;

  AppBloc(this.authRepository) : super(AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
  }

  Future<void> checkLoginStatus(Emitter<AppState> emit) async {
    final loggedIn = await authRepository.isLoggedIn();
    emit(loggedIn ? AppAuthenticated() : AppUnauthenticated());
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
}
