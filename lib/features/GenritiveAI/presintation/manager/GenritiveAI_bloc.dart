import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hikayati_app/dataProviders/error/failures.dart';

import 'package:equatable/equatable.dart';

import '../../date/repository/GenritiveAIRepository.dart';

part 'GenritiveAI_event.dart';
part 'GenritiveAI_state.dart';

class GenritiveAIBloc extends Bloc<GenritiveAIEvent, GenritiveAIState> {
  final GenritiveAIRepository repository;
  GenritiveAIBloc({required this.repository}) : super(GenritiveAIInitial());
  @override
  Stream<GenritiveAIState> mapEventToState(GenritiveAIEvent event) async* {
    if (event is GenritiveAI) {
      yield GenritiveAILoading();
      final failureOrData =
          await repository.GenritiveAI(password: event.password, email: event.email);
      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield GenritiveAIError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield GenritiveAILoaded(
            successMessage: 'تم تسجيل الدخول بنجاح',
          );
        },
      );
    }

    // if (event is Signup) {
    //   yield GenritiveAILoading();
    //   final failureOrData =
    //       await repository.signup(password: event.password, email: event.email);
    //   yield* failureOrData.fold(
    //     (failure) async* {
    //       log('yield is error');
    //       yield RegisterError(errorMessage: mapFailureToMessage(failure));
    //     },
    //     (data) async* {
    //       log('yield is loaded');
    //       yield RegisterLoaded(successMessage: data);
    //     },
    //   );
    // }
  }
}
