import 'package:atym_flutter_app/cubits/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  group('Counter Cubit test ', () {
    blocTest<CounterCubit, int>(
      'emits counter when increment button tapped ',
      build: () => CounterCubit(),
      act: (bloc) {
        return bloc.increment();
      },
      expect: () => [
        isA<int>().having(
          (source) => source,
          'increased to 1',
          1,
        ),
      ],
    );

    blocTest<CounterCubit, int>(
      'emits counter when decrement button tapped ',
      build: () => CounterCubit(),
      act: (bloc) {
        return bloc.decrement();
      },
      expect: () => [
        isA<int>().having(
          (source) => source,
          'decreased to -1',
          -1,
        ),
      ],
    );

    blocTest<CounterCubit, int>(
      'emits counter when reset button tapped ',
      build: () => CounterCubit(),
      seed: () => 1,
      act: (bloc) {
        return bloc.reset();
      },
      expect: () => [
        isA<int>().having(
          (source) => source,
          'reset to 0',
          0,
        ),
      ],
    );
  });
}
