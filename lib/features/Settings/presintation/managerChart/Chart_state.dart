
import 'package:equatable/equatable.dart';
import 'package:hikayati_app/features/Settings/date/model/ChartModel.dart';
import 'package:hikayati_app/features/Settings/date/model/ReportModel.dart';

import '../../../Story/date/model/StoryMediaModel.dart';
import '../../../Home/data/model/StoryMode.dart';
import '../../date/model/ChartModel.dart';
import '../../date/model/ChartModel.dart';

abstract class ChartState extends Equatable {
  const ChartState();
}

class ChartInitial extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoading extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartILoaded extends ChartState {

  List<ChartModel> chartModel;
  ChartILoaded({required this.chartModel});

  @override
  List<Object> get props => [ChartModel];
}

class ChartError extends ChartState {
  String errorMessage;

  ChartError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
