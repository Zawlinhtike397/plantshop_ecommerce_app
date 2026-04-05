import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/utils/network/bloc/network_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final NetworkBloc networkBloc;
  RegisterBloc({required this.authRepository, required this.networkBloc})
    : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterLoading());

      final hasInternet = await networkBloc.checkConnection();

      if (!hasInternet) {
        emit(RegisterFailure('No Internet Connection'));
        return;
      }

      final isNewUser = await authRepository.register(
        email: event.email,
        password: event.password,
        name: event.name,
        phone: event.phone,
      );

      if (!isNewUser) {
        emit(
          RegisterFailure(
            'Account already exists. Please login with Google or email.',
          ),
        );
        return;
      }

      emit(RegisterEmailVerificationSent());
    } catch (e) {
      final error = e.toString();

      if (error.contains('already registered')) {
        emit(
          RegisterFailure('Email already in use. Try login or Google sign-in.'),
        );
      } else {
        emit(RegisterFailure(error));
      }
    }
  }
}
