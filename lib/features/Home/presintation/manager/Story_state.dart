part of 'Story_bloc.dart';

abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitial extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryLoading extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryILoaded extends StoryState {

  List<StoryModel> storyModel;
  StoryILoaded({required this.storyModel});

  @override
  List<Object> get props => [storyModel];
}

class StoryError extends StoryState {
  String errorMessage;

  StoryError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
