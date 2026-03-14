import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;

  final _appLinks = AppLinks();
  StreamSubscription? linkSubscription;

  ForgotPasswordBloc({required this.authRepository})
    : super(ForgotPasswordInitial()) {
    on<SendResetEmail>(_onSendEmail);
    on<VerifyResetLink>(_onVerifyLink);
    on<SubmitNewPassword>(_onSubmitPassword);

    _initDeepLinks();
  }

  void _initDeepLinks() {
    linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (uri.queryParameters.containsKey('code')) {
        add(VerifyResetLink(uri));
      }
    });

    _appLinks.getInitialLink().then((uri) {
      if (uri != null && uri.queryParameters.containsKey('code')) {
        add(VerifyResetLink(uri));
      }
    });
  }

  @override
  Future<void> close() {
    linkSubscription?.cancel();
    return super.close();
  }

  Future<void> _onSendEmail(
    SendResetEmail event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      await authRepository.sendPasswordResetEmail(event.email);

      emit(ResetEmailSent());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> _onVerifyLink(
    VerifyResetLink event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      await authRepository.verifyPasswordResetLink(event.uri);
      emit(ResetLinkVerified());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> _onSubmitPassword(
    SubmitNewPassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      await authRepository.updatePassword(event.password);

      emit(PasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
