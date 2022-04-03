import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/cubit_states/cubit_state.dart';

class ErrorState extends CubitState {
  final AppException exception;

  ErrorState(AppException? exception)
      : this.exception = exception ?? FetchDataException();
}
