import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hikayati_app/dataProviders/error/failures.dart';
import 'package:hikayati_app/features/Home/data/repository/StoryRepository.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/StoryMode.dart';
import '../../data/model/StoryMode.dart';

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
      final failureOrData = await repository.getAllStory(event.level);
      yield*  failureOrData.fold(
            (failure) async* {
          log('yield is error');
          yield StoryError(errorMessage: mapFailureToMessage(failure));
        },
            (data) async* {
          log('yield is loaded');
          print(data);
          print('ddddddddddddddddddddddddddddddddddd');
          yield   StoryILoaded(storyModel: data);
        },
      );
    }



  }

}
