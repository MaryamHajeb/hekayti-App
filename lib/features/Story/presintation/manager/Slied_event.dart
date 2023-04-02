
import 'package:equatable/equatable.dart';

abstract class SliedEvent extends Equatable {
  const SliedEvent();
}

class GetAllCategoriesSlied extends SliedEvent {
  String token,category_id;


  GetAllCategoriesSlied({required this.token,required this.category_id});

  @override
  List<Object> get props => [];
}
