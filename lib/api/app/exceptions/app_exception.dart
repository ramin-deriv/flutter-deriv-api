import 'package:flutter_deriv_api/api/exceptions/api_base_exception.dart';

/// App exception
class AppException extends APIBaseException {
  /// Class constructor
  AppException({String message}) : super(message: message);
}
