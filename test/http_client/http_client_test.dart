import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/unauthorised_exception.dart';
import 'package:atym_flutter_app/core/http_client/default_http_client.dart';
import 'package:atym_flutter_app/core/http_client/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockResponse extends Mock implements Response {}

class MockClient extends Mock implements Client {}

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
  late final Client client;
  late final HttpClient httpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
    response = MockResponse();
    client = MockClient();
    httpClient = DefaultHttpClient(client: client);
  });

  group('Http Client test ', () {
    test('call get and receive the correct result', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(response),
      );
      when(() => response.body).thenReturn(_Mock.mockBody);
      when(() => response.statusCode).thenReturn(HttpStatus.ok);

      final Response result = await httpClient.get(
        Uri(path: 'path'),
      );

      expect(result.body, isNotEmpty);
    });

    test('call get and throws unauthorized', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(response),
      );
      when(() => response.body).thenReturn(_Mock.mockBody);
      when(() => response.statusCode).thenReturn(HttpStatus.unauthorized);

      expect(
          () async => await httpClient.get(
                Uri(path: 'path'),
              ),
          throwsA(isA<UnauthorisedException>()));
    });

    test('call get and throws FetchDataException', () async {
      when(
        () => client.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(response),
      );
      when(() => response.body).thenReturn(_Mock.mockBody);
      when(() => response.statusCode).thenReturn(HttpStatus.forbidden);

      expect(
          () async => await httpClient.get(
                Uri(path: 'path'),
              ),
          throwsA(isA<FetchDataException>()));
    });
  });
}
