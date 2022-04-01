import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';

class FetchDataException extends AppException {
  const FetchDataException([
    String? message,
  ]) : super(
          type: ExceptionType.fetchData,
          message: message,
        );
}
