import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/offline_exception.dart';
import 'package:atym_flutter_app/core/cubit_states/cubit_state.dart';
import 'package:atym_flutter_app/core/cubit_states/data_state.dart';
import 'package:atym_flutter_app/core/cubit_states/error_state.dart';
import 'package:atym_flutter_app/core/cubit_states/loading_state.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final FakeHeroesRepository repository;

  setUpAll(() {
    repository = FakeHeroesRepository();
  });

  group('Heroes Cubit test ', () {
    blocTest<HeroesCubit, CubitState>(
      'emits [LoadingState, DataState<List<HeroViewModel>>] when getHeroes called',
      build: () => HeroesCubit(repository),
      act: (bloc) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fromData,
        );
        return await bloc.getHeroes();
      },
      expect: () => [
        isA<LoadingState>(),
        isA<DataState<List<HeroViewModel>>>().having(
          (source) => source.data.length,
          'items length',
          24,
        ),
      ],
    );

    blocTest<HeroesCubit, CubitState>(
      'emits [LoadingState, ErrorState of type FetchDataException] when getHeroes called',
      build: () => HeroesCubit(repository),
      act: (bloc) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fetchException,
        );
        return await bloc.getHeroes();
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>().having(
          (source) => source.exception is FetchDataException,
          'FetchDataException',
          true,
        ),
      ],
    );

    blocTest<HeroesCubit, CubitState>(
      'emits [LoadingState, ErrorState of type OfflineException] when getHeroes called',
      build: () => HeroesCubit(repository),
      act: (bloc) async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.offline,
        );
        return await bloc.getHeroes();
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>().having(
          (source) => source.exception is OfflineException,
          'FetchDataException',
          true,
        ),
      ],
    );
  });
}
