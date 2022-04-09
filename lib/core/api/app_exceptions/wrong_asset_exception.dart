import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';

class WrongAssetException extends AppException {
  final String? path;
  const WrongAssetException([this.path])
      : super(
          type: ExceptionType.wrongAsset,
          message: 'Wrong asset with path: ${path ?? 'not provided'}',
        );
}
