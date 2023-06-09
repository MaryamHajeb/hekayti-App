part of 'Story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
}

class GetAllStory extends StoryEvent {


  GetAllStory();


  @override
  List<Object> get props => [];
}

class GetLast10Story extends StoryEvent {
  @override
  List<Object> get props => [];
}
