import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';

class ApiResponse<T> {
  late bool isSuccess;
  final T? data;
  final AppException? exception;

  ApiResponse({
    this.data,
    this.exception,
  }) {
    isSuccess = data != null;
  }
}
