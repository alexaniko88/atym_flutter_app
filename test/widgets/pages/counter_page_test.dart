import 'package:atym_flutter_app/cubits/counter_cubit.dart';
import 'package:atym_flutter_app/ui/widgets/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widget_tests_helper.dart';

void main() {
  group('CounterPage tests', () {
    testWidgets(
      'CounterPage with default value, increasing, decreasing, reset value',
      (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          CounterView(),
          optionalWrapper: (child) => BlocProvider(
            create: (_) => CounterCubit(),
            child: child,
          ),
        );
        await WidgetTestsHelper.expectGolden('counter_page_test_1');
        expect(find.text('0'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('counter_page_test_2');
        expect(find.text('1'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.remove));
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('counter_page_test_3');
        expect(find.text('-1'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.sync));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('counter_page_test_4');
        expect(find.text('0'), findsOneWidget);
      },
    );
  });
}
