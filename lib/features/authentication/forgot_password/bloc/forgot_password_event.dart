part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

final class SendResetEmail extends ForgotPasswordEvent {
  final String email;

  const SendResetEmail(this.email);

  @override
  List<Object> get props => [email];
}

final class VerifyResetLink extends ForgotPasswordEvent {
  final Uri uri;

  const VerifyResetLink(this.uri);

  @override
  List<Object> get props => [uri];
}

final class SubmitNewPassword extends ForgotPasswordEvent {
  final String password;

  const SubmitNewPassword(this.password);

  @override
  List<Object> get props => [password];
}
