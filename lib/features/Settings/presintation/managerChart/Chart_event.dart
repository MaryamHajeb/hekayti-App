
import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();
}

class GetAllChart extends ChartEvent {

String id;

  GetAllChart({required this.id});

  @override
  List<Object> get props => [];
}
