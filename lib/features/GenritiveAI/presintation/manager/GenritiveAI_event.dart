part of 'GenritiveAI_bloc.dart';

abstract class GenritiveAIEvent extends Equatable {
  const GenritiveAIEvent();
}

class GenritiveAI extends GenritiveAIEvent {
  String password, email;

  GenritiveAI({required this.password, required this.email});

  @override
  List<Object> get props => [];
}

// class Login extends GenritiveAIEvent {
//   String email, password;
//
//   Login({required this.email, required this.password});
//
//   @override
//   List<Object> get props => [];
// }
