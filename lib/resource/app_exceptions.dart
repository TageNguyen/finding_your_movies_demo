import 'package:finding_your_movies_demo/enums/exception_type.dart';

class AppException implements Exception {
  ExceptionType type;
  String message;

  AppException(this.type, [this.message = '']);
}
