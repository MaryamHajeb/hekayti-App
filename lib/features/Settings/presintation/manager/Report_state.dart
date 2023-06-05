
import 'package:equatable/equatable.dart';

import '../../date/model/StoryMediaModel.dart';
import '../../../Home/data/model/StoryMode.dart';

abstract class ReportState extends Equatable {
  const ReportState();
}

class ReportInitial extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportLoading extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportILoaded extends ReportState {

  List<StoryMediaModel> ReportModel;
  ReportILoaded({required this.ReportModel});

  @override
  List<Object> get props => [ReportModel];
}

class ReportError extends ReportState {
  String errorMessage;

  ReportError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
