import 'package:atym_flutter_app/services/connectivity/connectivity_service.dart';
import 'package:atym_flutter_app/services/connectivity/default_connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityWrapperCubit extends Cubit<bool> {
  final ConnectivityService _connectivityService;

  ConnectivityWrapperCubit({ConnectivityService? connectivityService})
      : this._connectivityService =
            connectivityService ?? DefaultConnectivityService(),
        super(true);

  void setConnectivityListener() {
    _connectivityService.setConnectivityListener(
      doOnConnected: doOnDisconnected,
      doOnDisconnected: doOnDisconnected,
    );
  }

  @visibleForTesting
  void doOnConnected() => emit(true);

  @visibleForTesting
  void doOnDisconnected() => emit(false);

  @override
  Future<void> close() {
    this._connectivityService.disposeConnectivityListener();
    return super.close();
  }
}
