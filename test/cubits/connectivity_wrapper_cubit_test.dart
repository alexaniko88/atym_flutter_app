import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/services/connectivity/connectivity_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  group('Counter Cubit test ', () {
    blocTest<ConnectivityWrapperCubit, bool>(
      'emits true when doOnConnected called',
      build: () => ConnectivityWrapperCubit(),
      act: (bloc) {
        return bloc.doOnConnected();
      },
      expect: () => [
        isA<bool>().having(
          (source) => source,
          'true',
          true,
        ),
      ],
    );

    blocTest<ConnectivityWrapperCubit, bool>(
      'emits false when doOnDisconnected called',
      build: () => ConnectivityWrapperCubit(),
      act: (bloc) {
        return bloc.doOnDisconnected();
      },
      expect: () => [
        isA<bool>().having(
          (source) => source,
          'false',
          false,
        ),
      ],
    );

    test('test setConnectivityListener and dispose', () async {
      final connectivityService = MockConnectivityService();
      when(
        () => connectivityService.setConnectivityListener(
          doOnConnected: any(named: 'doOnConnected'),
          doOnDisconnected: any(named: 'doOnDisconnected'),
        ),
      ).thenReturn(() {});
      when(
        () => connectivityService.disposeConnectivityListener(),
      ).thenAnswer((invocation) => Future.value());
      final bloc = ConnectivityWrapperCubit(
        connectivityService: connectivityService,
      );
      bloc.setConnectivityListener();
      verify(() {
        connectivityService.setConnectivityListener(
          doOnConnected: any(named: 'doOnConnected'),
          doOnDisconnected: any(named: 'doOnDisconnected'),
        );
      }).called(1);
      await bloc.close();
      verify(() {
        connectivityService.disposeConnectivityListener();
      }).called(1);
    });
  });
}
