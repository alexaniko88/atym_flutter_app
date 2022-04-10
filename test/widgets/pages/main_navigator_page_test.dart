import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/cubits/counter_cubit.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/ui/pages/main_navigator_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../widget_tests_helper.dart';

class MockConnectivityWrapperCubit extends MockCubit<bool>
    implements ConnectivityWrapperCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeHeroesRepository repository;
  late ConnectivityWrapperCubit connectivityWrapperCubit;
  late Locale locale;

  setUpAll(() {
    locale = Locale('en');
    connectivityWrapperCubit = MockConnectivityWrapperCubit();
    repository = FakeHeroesRepository();
  });

  group('HeroesView tests', () {
    testWidgets(
      'pump MainNavigatorPage and testing counter',
      (WidgetTester tester) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fromData,
        );
        when(() => connectivityWrapperCubit.state).thenReturn(true);
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: MainNavigatorPage(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository),
              ),
              BlocProvider(
                create: (_) => CounterCubit(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_1');
        expect(find.text('0'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_2');
        expect(find.text('1'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.remove));
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_3');
        expect(find.text('-1'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.sync));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_4');
        expect(find.text('0'), findsOneWidget);
      },
    );

    testWidgets(
      'pump MainNavigatorPage and testing heroes view',
      (WidgetTester tester) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fromData,
        );
        when(() => connectivityWrapperCubit.state).thenReturn(true);
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: MainNavigatorPage(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository),
              ),
              BlocProvider(
                create: (_) => CounterCubit(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.list_alt));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_5');

        final gesture = await tester.startGesture(Offset(0, 300));
        await gesture.moveBy(Offset(0, -100));
        await tester.pump();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_6');
      },
    );

    testWidgets(
      'pump MainNavigatorPage and switching language',
      (WidgetTester tester) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fromData,
        );
        when(() => connectivityWrapperCubit.state).thenReturn(true);
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: MainNavigatorPage(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository),
              ),
              BlocProvider(
                create: (_) => CounterCubit(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.g_translate));
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_7');
      },
    );

    testWidgets(
      'pump MainNavigatorPage and turning connection off',
      (WidgetTester tester) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fromData,
        );
        when(() => connectivityWrapperCubit.state).thenReturn(false);
        when(() => connectivityWrapperCubit.stream).thenAnswer(
          (invocation) => Stream.value(false),
        );
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: MainNavigatorPage(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository),
              ),
              BlocProvider(
                create: (_) => CounterCubit(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('main_navigator_page_test_8');
      },
    );
  });
}
