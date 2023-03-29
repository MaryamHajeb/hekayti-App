part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegisterLoaded extends RegistrationState {
  String successMessage;
  RegisterLoaded({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class RegisterError extends RegistrationState {
  String errorMessage;

  RegisterError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
