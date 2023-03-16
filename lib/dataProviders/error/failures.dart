import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

// general failures

class NotFoundFailure extends Failure{
  @override
  List<Object?> get props => [];
  
}
class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
  
}
class NotAvailableFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class BlockedUserFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class ValidationFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class ConnectionFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class CacheFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class NotFounFailure extends Failure{
  @override
  List<Object?> get props => [];

}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'عذراً لم نتمكن من الاتصال بالخادم';
    case NotFoundFailure:
      return 'لاتوجد أي بيانات في الوقت الحالي!';

     case BlockedUserFailure:
      return 'عذرا ! لقد تم حظر حسابك. يرجى التواصل مع المسؤول لإزالة الحظر';
    case NotAvailableFailure:
      return 'هذا الطلب غير متاح ';
    case ValidationFailure:
      return 'البيانات التي ادخلتها غير صحيحه ';
      case ConnectionFailure:
      return 'لا يوجد اتصال بالانترنت ';
      case NotFounFailure:
      return 'البيانات غير موجودة ';
      case CacheFailure:
      return 'لا يوجد بيانات بالتخزين المؤقت ';
    default:
      return 'عذراً حدث خطأ غير متوقع';
  }
}
