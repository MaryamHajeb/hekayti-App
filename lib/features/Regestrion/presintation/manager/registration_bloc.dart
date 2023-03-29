import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hikayati_app/dataProviders/error/failures.dart';

import 'package:equatable/equatable.dart';

import '../../date/repository/registrationRepository.dart';


part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository repository;
  RegistrationBloc({required this.repository})
      : assert(repository != null),
        super(RegistrationInitial());
  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is Login) {
      yield RegistrationLoading();
      final failureOrData = await repository.login(password: event.password,email: event.email);
      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield RegisterError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield RegisterLoaded(
            successMessage: 'تم تسجيل الدخول بنجاح',
          );
        },
      );
    }

    if (event is Signup) {
      yield RegistrationLoading();
      final failureOrData = await repository.signup(

          password: event.password,
          email: event.email);
      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield RegisterError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield RegisterLoaded(successMessage: data);
        },
      );
    }
  }
}
