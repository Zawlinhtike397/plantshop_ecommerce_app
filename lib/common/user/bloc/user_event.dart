part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}

class LogoutUser extends UserEvent {}

class UpdateProfilePicture extends UserEvent {}

class UpdateUserField extends UserEvent {
  final String field;
  final dynamic value;

  const UpdateUserField({required this.field, required this.value});

  @override
  List<Object> get props => [field, value];
}
