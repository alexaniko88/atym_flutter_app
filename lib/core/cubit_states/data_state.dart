import 'package:atym_flutter_app/core/cubit_states/cubit_state.dart';

class DataState<T> extends CubitState {
  final T data;

  DataState(this.data);
}
