import 'package:flutter/cupertino.dart';

abstract class ConnectivityService {
  Future<bool> hasConnection();

  void setConnectivityListener({
    VoidCallback? doOnConnected,
    VoidCallback? doOnDisconnected,
  });

  Future disposeConnectivityListener();
}
