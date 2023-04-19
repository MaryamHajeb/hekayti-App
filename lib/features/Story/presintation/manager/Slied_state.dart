
import 'package:equatable/equatable.dart';

import '../../date/model/MeadiaModel.dart';
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

  List<MeadiaModel> SliedModel;
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
