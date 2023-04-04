import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hikayati_app/dataProviders/error/failures.dart';
import 'package:hikayati_app/features/Home/data/repository/StoryRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../Story/date/model/StoryMode.dart';
import '../../../Story/date/model/StoryMode.dart';

part 'Story_event.dart';
part 'Story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {

  final StoryRepository repository;
  StoryBloc({required this.repository})
      : assert(repository != null),
        super(StoryInitial());
  @override
  Stream<StoryState> mapEventToState(StoryEvent event)async* {

    if(event is GetAllStory){
      yield StoryLoading();
      final failureOrData = await repository.getAllStory(token: event.token);
      yield* failureOrData.fold(
            (failure) async* {
          log('yield is error');
          yield StoryError(errorMessage: mapFailureToMessage(failure));
        },
            (data) async* {
          log('yield is loaded');
          yield StoryILoaded(storyModel: data,);
        },
      );
    }



  }

}
