import 'dart:async';
import 'dart:developer';


import 'package:bloc/bloc.dart';
import 'package:hikayati_app/features/Story/presintation/manager/Slied_event.dart';
import 'package:hikayati_app/features/Story/presintation/manager/Slied_state.dart';
import 'package:equatable/equatable.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../date/repository/SliedsRepository.dart';


class SliedBloc extends Bloc<SliedEvent, SliedState> {

  final SliedRepository repository;
  SliedBloc({required this.repository})
      : assert(repository != null),
        super(SliedInitial());
  @override
  Stream<SliedState> mapEventToState(SliedEvent event)async* {

    if(event is GetAllCategoriesSlied){
      yield SliedLoading();
      final failureOrData = await repository.getAllCategoriesSlied(category_id: event.category_id,token: event.token);
      yield* failureOrData.fold(
            (failure) async* {
          log('yield is error');
          yield SliedError(errorMessage: mapFailureToMessage(failure));
        },
            (data) async* {
          log('yield is loaded');
          yield SliedLoaded(SliedModel:  data,);
        },
      );
    }



  }

}
