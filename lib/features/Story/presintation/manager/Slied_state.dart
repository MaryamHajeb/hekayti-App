
import 'package:equatable/equatable.dart';

import '../../date/model/StoryMediaModel.dart';
import '../../../Home/data/model/StoryMode.dart';

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

class SliedILoaded extends SliedState {

  List<StoryMediaModel> SliedModel;
  SliedILoaded({required this.SliedModel});

  @override
  List<Object> get props => [SliedModel];
}

class SliedError extends SliedState {
  String errorMessage;

  SliedError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
