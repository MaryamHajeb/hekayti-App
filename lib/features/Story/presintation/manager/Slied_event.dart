import 'package:equatable/equatable.dart';

abstract class SliedEvent extends Equatable {
  const SliedEvent();
}

class GetAllSlied extends SliedEvent {
  String story_id, tableName;

  GetAllSlied({required this.story_id, required this.tableName});

  @override
  List<Object> get props => [];
}
