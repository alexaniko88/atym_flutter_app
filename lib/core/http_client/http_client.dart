import 'package:http/http.dart';

abstract class HttpClient {
  Future<Response> get(
    Uri uri, {
    Map<String, String>? headers,
  });
}
