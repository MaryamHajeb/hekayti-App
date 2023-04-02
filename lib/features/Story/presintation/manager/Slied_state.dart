
import 'package:equatable/equatable.dart';

import '../../date/model/StoryMode.dart';

abstract class SliedState extends Equatable {
  const SliedState();
}

class SliedInitial extends SliedState {
  @override
  List<Object> get props => [];
}

class SliedLoading extends SliedState {
  @override
  List<Object> get props => [];
}

class SliedLoaded extends SliedState {

  List<StoryModel> SliedModel;
  SliedLoaded({required this.SliedModel});

  @override
  List<Object> get props => [SliedModel];
}

class SliedError extends SliedState {
  String errorMessage;

  SliedError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
