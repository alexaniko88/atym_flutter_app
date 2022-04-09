import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/heroes_api.dart';
import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/repositories/heroes/default_heroes_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/heroes_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHeroesApi extends Mock implements HeroesApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final HeroesApi api;
  late final HeroesRepository repository;

  setUpAll(() {
    registerFallbackValue(RouteType.allHeroes);
    api = MockHeroesApi();
    repository = DefaultHeroesRepository(api);
  });

  group('Default Heroes Repository test ', () {
    test('call getAllHeroes and receive the correct result', () async {
      when(() => api.get(any(), heroId: any(named: 'heroId'))).thenAnswer(
        (invocation) async => Future.value(
          ApiResponse(
            data: await FakeHeroesRepository().readFromAssets(),
          ),
        ),
      );
      final result = await repository.getAllHeroes();

      expect(result.isSuccess, true);
      expect(result.exception, isNull);
      expect(result.data, isNotEmpty);
      expect(result.data!.length, 24);
    });

    test('call getAllHeroes and failing with exception', () async {
      when(() => api.get(any(), heroId: any(named: 'heroId'))).thenAnswer(
        (invocation) async => Future.value(
          ApiResponse(exception: FetchDataException()),
        ),
      );
      final result = await repository.getAllHeroes();

      expect(result.isSuccess, false);
      expect(result.exception, isNotNull);
      expect(result.exception is FetchDataException, true);
      expect(result.data, isNull);
    });

    test('call getAllHeroes and failing without exception', () async {
      when(() => api.get(any(), heroId: any(named: 'heroId'))).thenAnswer(
        (invocation) async => Future.value(
          ApiResponse(
            exception: null,
            data: null,
          ),
        ),
      );
      final result = await repository.getAllHeroes();

      expect(result.isSuccess, false);
      expect(result.exception, isNotNull);
      expect(result.exception is FetchDataException, true);
      expect(result.data, isNull);
    });
  });
}
