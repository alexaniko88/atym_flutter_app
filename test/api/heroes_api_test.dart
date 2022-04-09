import 'dart:io';

import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/offline_exception.dart';
import 'package:atym_flutter_app/core/api/default_heroes_api.dart';
import 'package:atym_flutter_app/core/api/heroes_api.dart';
import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/core/http_client/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockResponse extends Mock implements Response {}

class FakeUri extends Fake implements Uri {}

class _Mock {
  static const String mockBody = """
  {
    "id": "id",
    "item": "item"
  }
  """;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final Response response;
  late final HttpClient client;
  late final HeroesApi api;

  setUpAll(() {
    registerFallbackValue(FakeUri());
    response = MockResponse();
    client = MockHttpClient();
    api = DefaultHeroesApi(client);
  });

  group('Heroes Api test', () {
    test('call get with route and receive the correct result', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(response),
      );
      when(() => response.body).thenReturn(_Mock.mockBody);
      final ApiResponse result = await api.get(
        RouteType.allHeroes,
      );
      expect(result.isSuccess, true);
      expect(result.exception, isNull);
      expect(result.data, isNotEmpty);
    });

    test('call get with route and receive socket exception', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(SocketException('message'));
      when(() => response.body).thenReturn(_Mock.mockBody);
      final ApiResponse result = await api.get(
        RouteType.heroAppearance,
        heroId: 'heroId'
      );
      expect(result.isSuccess, false);
      expect(result.exception is OfflineException, true);
      expect(result.data, isNull);
    });

    test('call get with route and receive app exception', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(AppException());
      when(() => response.body).thenReturn(_Mock.mockBody);
      final ApiResponse result = await api.get(
        RouteType.heroInfo,
        heroId: 'heroId'
      );
      expect(result.isSuccess, false);
      expect(result.exception is AppException, true);
      expect(result.data, isNull);
    });

    test('call get with route and receive exception', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception());
      when(() => response.body).thenReturn(_Mock.mockBody);
      final ApiResponse result = await api.get(
        RouteType.heroPowerStats,
        heroId: 'heroId'
      );
      expect(result.isSuccess, false);
      expect(result.exception is FetchDataException, true);
      expect(result.data, isNull);
    });
  });
}
