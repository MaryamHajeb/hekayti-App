part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class Signup extends RegistrationEvent {
  String  password, email;

  Signup({ required this.password, required this.email});

  @override
  List<Object> get props => [];
}

class Login extends RegistrationEvent {
  String email, password;

  Login({required this.email, required this.password});

  @override
  List<Object> get props => [];
}
