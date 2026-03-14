import 'package:bloc/bloc.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AppBloc appBloc;
  final NetworkBloc networkBloc;
  final UserBloc userBloc;
  final UserRepository userRepository;
  final NavigationCubit navigationCubit;

  LoginBloc({
    required this.authRepository,
    required this.userRepository,
    required this.appBloc,
    required this.networkBloc,
    required this.userBloc,
    required this.navigationCubit,
  }) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());

      final hasInternet = await networkBloc.checkConnection();

      if (!hasInternet) {
        emit(LoginFailure('No Internet Connection'));
        return;
      }

      await authRepository.login(event.email, event.password);

      await userRepository.addOrUpdateUserData();

      appBloc.add(AuthStatusChanged());

      userBloc.add(LoadUser());
      navigationCubit.changeIndex(0);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());

      final hasInternet = await networkBloc.checkConnection();

      if (!hasInternet) {
        emit(LoginFailure('No Internet Connection'));
        return;
      }

      await authRepository.signInWithGoogle();

      await userRepository.addOrUpdateUserData();

      appBloc.add(AuthStatusChanged());

      userBloc.add(LoadUser());

      navigationCubit.changeIndex(0);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
