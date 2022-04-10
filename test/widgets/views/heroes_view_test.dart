import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/ui/widgets/heroes_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      'pump HeroesView from data',
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
            child: HeroesView(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository)..getHeroes(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('heroes_view_test_1');
      },
    );

    testWidgets(
      'pump HeroesView with fetch exception',
          (WidgetTester tester) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fetchException,
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
            child: HeroesView(),
          ),
          optionalWrapper: (child) => MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => connectivityWrapperCubit,
              ),
              BlocProvider(
                create: (_) => HeroesCubit(repository)..getHeroes(),
              ),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await tester.pumpAndSettle();
        await WidgetTestsHelper.expectGolden('heroes_view_test_2');
      },
    );
  });
}
