
import 'package:equatable/equatable.dart';
import 'package:hikayati_app/features/Settings/date/model/ReportModel.dart';

import '../../../Story/date/model/StoryMediaModel.dart';
import '../../../Home/data/model/StoryMode.dart';
import '../../date/model/ReportModel.dart';
import '../../date/model/ReportModel.dart';

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

  List<ReportModel> reportModel;
  ReportILoaded({required this.reportModel});

  @override
  List<Object> get props => [ReportModel];
}

class ReportError extends ReportState {
  String errorMessage;

  ReportError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
