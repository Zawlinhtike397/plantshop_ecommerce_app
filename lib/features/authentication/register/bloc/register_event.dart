part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object> get props => [name, email, password, phone];
}
