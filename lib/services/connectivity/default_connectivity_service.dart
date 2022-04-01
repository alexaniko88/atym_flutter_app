import 'dart:async';
import 'dart:ui';

import 'package:atym_flutter_app/services/connectivity/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DefaultConnectivityService implements ConnectivityService {
  final Connectivity? connectivity;
  StreamSubscription<ConnectivityResult>? _connectivityStatusListener;

  DefaultConnectivityService({
    Connectivity? connectivity,
  }) : this.connectivity = connectivity ?? Connectivity() {}

  @override
  Future<bool> hasConnection() async {
    final result = await connectivity?.checkConnectivity();
    return _hasConnection(result);
  }

  @override
  void setConnectivityListener({
    VoidCallback? doOnConnected,
    VoidCallback? doOnDisconnected,
  }) {
    _connectivityStatusListener =
        connectivity?.onConnectivityChanged.listen((result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          doOnConnected?.call();
          break;
        case ConnectivityResult.ethernet:
        // Not used.
        case ConnectivityResult.bluetooth:
        // Not used.
        case ConnectivityResult.none:
          doOnDisconnected?.call();
          break;
      }
    });
  }

  @override
  Future disposeConnectivityListener() async =>
      await _connectivityStatusListener?.cancel();

  bool _hasConnection(ConnectivityResult? result) =>
      (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi)
          ? true
          : false;
}
