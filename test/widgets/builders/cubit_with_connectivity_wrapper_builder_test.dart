import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/ui/builders/cubit_with_connectivity_wrapper_builder.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../widget_tests_helper.dart';

class MockConnectivityWrapperCubit extends MockCubit<bool>
    implements ConnectivityWrapperCubit {}

void main() {
  late ConnectivityWrapperCubit connectivityWrapperCubit;
  late HeroesCubit heroesCubit;
  late FakeHeroesRepository repository;

  setUp(() {
    repository = FakeHeroesRepository();
    connectivityWrapperCubit = MockConnectivityWrapperCubit();
    heroesCubit = HeroesCubit(repository);
  });

  group('Cubit With Connectivity Wrapper Builder test from data', () {
    setUp(() async {
      repository.updateConfiguration(
        repositoryResponseType: RepositoryResponseType.fromData,
      );
      await heroesCubit.getHeroes();
    });
    testWidgets(
      'CubitWithConnectivityWrapperBuilder test from data',
      (WidgetTester tester) async {
        when(() => connectivityWrapperCubit.state).thenReturn(true);
        await WidgetTestsHelper.testWidget(
          tester,
          CubitWithConnectivityWrapperBuilder<HeroesCubit, List<HeroViewModel>>(
            cubit: heroesCubit,
            listener: (context, isOnline) {},
            connectivityListenerCallback: (context, cubit, isOnline) {
              debugPrint('isOnline? $isOnline');
            },
            builder: (context, cubit, data, isOnline) {
              return Text('DATA');
            },
          ),
          optionalWrapper: (child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => connectivityWrapperCubit),
              BlocProvider(create: (_) => heroesCubit),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden(
            'cubit_with_connectivity_wrapper_builder_test_1');
      },
    );
  });

  group('Cubit With Connectivity Wrapper Builder test offline', () {
    setUp(() async {
      repository.updateConfiguration(
        repositoryResponseType: RepositoryResponseType.offline,
      );
      await heroesCubit.getHeroes();
    });
    testWidgets(
      'CubitWithConnectivityWrapperBuilder test offline',
      (WidgetTester tester) async {
        when(() => connectivityWrapperCubit.state).thenReturn(false);
        await WidgetTestsHelper.testWidget(
          tester,
          CubitWithConnectivityWrapperBuilder<HeroesCubit, List<HeroViewModel>>(
            cubit: heroesCubit,
            listener: (context, isOnline) {},
            connectivityListenerCallback: (context, cubit, isOnline) {
              debugPrint('isOnline? $isOnline');
            },
            builder: (context, cubit, data, isOnline) {
              return Text('DATA');
            },
          ),
          optionalWrapper: (child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => connectivityWrapperCubit),
              BlocProvider(create: (_) => heroesCubit),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden(
            'cubit_with_connectivity_wrapper_builder_test_2');
      },
    );
  });

  group('Cubit With Connectivity Wrapper Builder test fetch exception', () {
    setUp(() async {
      repository.updateConfiguration(
        repositoryResponseType: RepositoryResponseType.fetchException,
      );
      await heroesCubit.getHeroes();
    });
    testWidgets(
      'CubitWithConnectivityWrapperBuilder test fetch exception',
          (WidgetTester tester) async {
        when(() => connectivityWrapperCubit.state).thenReturn(false);
        await WidgetTestsHelper.testWidget(
          tester,
          CubitWithConnectivityWrapperBuilder<HeroesCubit, List<HeroViewModel>>(
            cubit: heroesCubit,
            listener: (context, isOnline) {},
            connectivityListenerCallback: (context, cubit, isOnline) {
              debugPrint('isOnline? $isOnline');
            },
            builder: (context, cubit, data, isOnline) {
              return Text('DATA');
            },
          ),
          optionalWrapper: (child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => connectivityWrapperCubit),
              BlocProvider(create: (_) => heroesCubit),
            ],
            child: child,
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden(
            'cubit_with_connectivity_wrapper_builder_test_3');
      },
    );
  });
}
