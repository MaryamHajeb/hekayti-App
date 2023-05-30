
import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class GetAllReport extends ReportEvent {
  String story_id,tableName;


  GetAllReport({required this.story_id,required this.tableName});

  @override
  List<Object> get props => [];
}
