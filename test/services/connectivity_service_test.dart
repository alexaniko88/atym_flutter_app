import 'package:atym_flutter_app/services/connectivity/connectivity_service.dart';
import 'package:atym_flutter_app/services/connectivity/default_connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final Connectivity connectivity;
  late final ConnectivityService service;

  setUpAll(() {
    connectivity = MockConnectivity();
    service = DefaultConnectivityService(connectivity: connectivity);
  });

  group('Default Connectivity Service test ', () {
    test('setConnectivityListener receiving mobile connection test', () async {
      (service as DefaultConnectivityService).isConnectivityStatusReceived =
          false;
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (invocation) => Stream.value(ConnectivityResult.mobile),
      );
      service.setConnectivityListener(
        doOnConnected: () {
          expect(
            (service as DefaultConnectivityService)
                .isConnectivityStatusReceived,
            true,
          );
        },
      );
      await service.disposeConnectivityListener();
      verify(() => connectivity.onConnectivityChanged).called(1);
    });

    test('setConnectivityListener receiving none connection test', () async {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (invocation) => Stream.value(ConnectivityResult.none),
      );
      service.setConnectivityListener(
        doOnDisconnected: () {
          expect(
            (service as DefaultConnectivityService)
                .isConnectivityStatusReceived,
            false,
          );
        },
      );
      await service.disposeConnectivityListener();
      verify(() => connectivity.onConnectivityChanged).called(1);
    });

    test('hasConnection test, true', () async {
      when(() => connectivity.checkConnectivity()).thenAnswer(
        (invocation) => Future.value(ConnectivityResult.wifi),
      );
      final result = await service.hasConnection();
      expect(result, true);
    });

    test('hasConnection test, false', () async {
      when(() => connectivity.checkConnectivity()).thenAnswer(
            (invocation) => Future.value(ConnectivityResult.none),
      );
      final result = await service.hasConnection();
      expect(result, false);
    });
  });
}
