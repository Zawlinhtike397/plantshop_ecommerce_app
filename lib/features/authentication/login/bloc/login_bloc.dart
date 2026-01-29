import 'package:bloc/bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AppBloc appBloc;
  final NetworkBloc networkBloc;

  LoginBloc({
    required this.networkBloc,
    required this.authRepository,
    required this.appBloc,
  }) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!networkBloc.state.hasInternet) {
      emit(LoginFailure('No Internet Connection'));
      return;
    }

    try {
      emit(LoginLoading());

      await authRepository.login(event.email, event.password);

      emit(LoginSuccess());

      appBloc.add(AppStarted());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (!networkBloc.state.hasInternet) {
      emit(LoginFailure('No Internet Connection'));
      return;
    }

    try {
      emit(LoginLoading());

      await authRepository.signInWithGoogle();

      emit(LoginSuccess());

      appBloc.add(AppStarted());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
