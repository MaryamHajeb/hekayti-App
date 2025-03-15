part of 'GenritiveAI_bloc.dart';

abstract class GenritiveAIState extends Equatable {
  const GenritiveAIState();
}

class GenritiveAIInitial extends GenritiveAIState {
  @override
  List<Object> get props => [];
}

class GenritiveAILoading extends GenritiveAIState {
  @override
  List<Object> get props => [];
}

class GenritiveAILoaded extends GenritiveAIState {
  String successMessage;
  GenritiveAILoaded({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class GenritiveAIError extends GenritiveAIState {
  String errorMessage;

  GenritiveAIError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
