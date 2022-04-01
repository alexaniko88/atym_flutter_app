import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';

class UnauthorisedException extends AppException {
  const UnauthorisedException([
    String? message,
  ]) : super(
          type: ExceptionType.unauthorised,
          message: message,
        );
}
