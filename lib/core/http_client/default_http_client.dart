import 'dart:io';

import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/unauthorised_exception.dart';
import 'package:atym_flutter_app/core/http_client/http_client.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DefaultHttpClient implements HttpClient {
  final Client client;

  DefaultHttpClient({Client? client}) : this.client = client ?? Client();

  @override
  Future<Response> get(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final response = await this.client.get(uri, headers: headers);
    return _processResponse(response);
  }

  Response _processResponse(Response response) {
    debugPrint('Response code: ${response.statusCode.toString()}');
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response;
      case HttpStatus.unauthorized:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(response.body.toString());
    }
  }
}
