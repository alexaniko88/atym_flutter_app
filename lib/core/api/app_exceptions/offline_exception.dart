import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';

class OfflineException extends AppException {
  const OfflineException()
      : super(
          type: ExceptionType.offline,
          message: 'Your app is offline, please check the connectivity!',
        );
}
