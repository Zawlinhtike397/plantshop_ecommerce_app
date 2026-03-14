import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/common/user/model/user_model.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
import 'package:plantify_plantshop_project/features/authentication/app/bloc/app_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final AppBloc appBloc;

  UserBloc({
    required this.authRepository,
    required this.appBloc,
    required this.userRepository,
  }) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<LogoutUser>(_onLogoutUser);
    on<UpdateUserField>(_onUpdateUserField);
    on<UpdateProfilePicture>(_onUpdateProfilePicture);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    try {
      final user = await userRepository.fetchCurrentUser();

      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<UserState> emit) async {
    try {
      await authRepository.logout();
      emit(UserInitial());
      appBloc.add(AuthStatusChanged());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUpdateUserField(
    UpdateUserField event,
    Emitter<UserState> emit,
  ) async {
    try {
      if (state is UserLoaded) {
        final updatedUser = await userRepository.updateSingleField(
          field: event.field,
          value: event.value,
        );

        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUpdateProfilePicture(
    UpdateProfilePicture event,
    Emitter<UserState> emit,
  ) async {
    try {
      if (state is UserLoaded) {
        final updatedUser = await userRepository.updateProfilePicture();
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
