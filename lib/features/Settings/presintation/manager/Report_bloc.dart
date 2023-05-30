import 'dart:async';
import 'dart:developer';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../date/repository/ReportRepository.dart';
import 'Report_event.dart';
import 'Report_state.dart';


class ReportBloc extends Bloc<ReportEvent, ReportState> {

  final ReportRepository repository;
  ReportBloc({required this.repository})
      : assert(repository != null),
        super(ReportInitial());
  @override
  Stream<ReportState> mapEventToState(ReportEvent event)async* {

    if(event is GetAllReport){
      yield ReportLoading();
      final failureOrData = await repository.getAllReport(story_id: event.story_id,tableName: event.tableName);
      yield* failureOrData.fold(
            (failure) async* {
          log('yield is error');
          yield ReportError(errorMessage: mapFailureToMessage(failure));
        },
            (data) async* {
          log('yield is loaded');
          yield ReportILoaded(ReportModel: data);
        },
      );
    }



  }

}
