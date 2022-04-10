import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/ui/widgets/connectivity_notification_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../widget_tests_helper.dart';

class MockConnectivityWrapperCubit extends MockCubit<bool>
    implements ConnectivityWrapperCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Locale locale;
  late ConnectivityWrapperCubit cubit;

  setUpAll(() {
    registerFallbackValue(true);
    locale = Locale('en');
  });

  setUp(() {
    cubit = MockConnectivityWrapperCubit();
  });

  group('ConnectivityNotificationView tests', () {
    testWidgets(
      'pump ConnectivityNotificationView with connection ON',
      (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(true);
        whenListen(cubit, Stream.value(true));
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: Container(
              height: 100,
              width: double.maxFinite,
              child: ConnectivityNotificationView(),
            ),
          ),
          optionalWrapper: (child) => BlocProvider(
            create: (_) => cubit,
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden(
            'connectivity_notification_view_test_1');
      },
    );

    testWidgets(
      'pump ConnectivityNotificationView with connection OFF',
          (WidgetTester tester) async {
        when(() => cubit.state).thenReturn(false);
        whenListen(cubit, Stream.value(false));
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: Container(
              height: 100,
              width: double.maxFinite,
              child: ConnectivityNotificationView(),
            ),
          ),
          optionalWrapper: (child) => BlocProvider(
            create: (_) => cubit,
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden(
            'connectivity_notification_view_test_2');
      },
    );
  });
}
