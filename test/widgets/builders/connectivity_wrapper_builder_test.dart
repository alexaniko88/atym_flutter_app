import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/ui/builders/connectivity_wrapper_builder.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../widget_tests_helper.dart';

class MockConnectivityWrapperCubit extends MockCubit<bool>
    implements ConnectivityWrapperCubit {}

void main() {
  late ConnectivityWrapperCubit cubit;

  setUp(() {
    cubit = MockConnectivityWrapperCubit();
  });

  group('Connectivity Wrapper Builder tests', () {
    testWidgets(
      'ConnectivityWrapperBuilder test when is online',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(true);
        await WidgetTestsHelper.testWidget(
          tester,
          ConnectivityWrapperBuilder(
            builder: (context, isOnline) {
              if (isOnline) {
                return Text('is online!');
              } else {
                return Text('is offline!');
              }
            },
            listener: (context, isOnline) {},
          ),
          optionalWrapper: (child) => BlocProvider(
            create: (_) => cubit,
            child: child,
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden(
            'connectivity_wrapper_builder_test_1');
      },
    );

    testWidgets(
      'ConnectivityWrapperBuilder test when is offline',
          (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(false);
        await WidgetTestsHelper.testWidget(
          tester,
          ConnectivityWrapperBuilder(
            builder: (context, isOnline) {
              if (isOnline) {
                return Text('is online!');
              } else {
                return Text('is offline!');
              }
            },
            listener: (context, isOnline) {},
          ),
          optionalWrapper: (child) => BlocProvider(
            create: (_) => cubit,
            child: child,
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden(
            'connectivity_wrapper_builder_test_2');
      },
    );
  });
}
