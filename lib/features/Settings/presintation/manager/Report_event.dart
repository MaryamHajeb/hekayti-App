
import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class GetAllReport extends ReportEvent {



  GetAllReport();

  @override
  List<Object> get props => [];
}
