import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../date/repository/ChartRepository.dart';
import 'Chart_event.dart';
import 'Chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ChartRepository repository;
  ChartBloc({required this.repository}) : super(ChartInitial());
  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is GetAllChart) {
      yield ChartLoading();
      final failureOrData = await repository.getAllChart(id: event.id);
      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield ChartError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield ChartILoaded(chartModel: data);
        },
      );
    }
  }
}
