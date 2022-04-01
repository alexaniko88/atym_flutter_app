import 'dart:convert';
import 'dart:io';

import 'package:atym_flutter_app/core/api/app_exceptions/app_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/offline_exception.dart';
import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/core/http_client/http_client.dart';
import 'package:atym_flutter_app/services/connectivity/connectivity_service.dart';
import 'package:atym_flutter_app/services/connectivity/default_connectivity_service.dart';

import 'heroes_api.dart';

class _Routes {
  static const String allHeroes = '/all';
  static const String heroInfo = '/id/';
  static const String heroPowerStats = '/powerstats/';
  static const String heroAppearance = '/appearance/';
}

class _Constants {
  static const String baseUrl = 'https://akabab.github.io/superhero-api/api';
  static const String extension = '.json';
}

class DefaultHeroesApi implements HeroesApi {
  final HttpClient client;
  final ConnectivityService connectivityService;

  DefaultHeroesApi(
    this.client, {
    ConnectivityService? connectivityService,
  }) : this.connectivityService =
            connectivityService ?? DefaultConnectivityService();

  @override
  Future<ApiResponse> get(
    RouteType routeType, {
    String? heroId,
  }) async {
    final uri = Uri.parse(
      _Constants.baseUrl +
          _mapRouteTypeToString(routeType) +
          (heroId ?? '') +
          _Constants.extension,
    );
    if (!await connectivityService.hasConnection()) {
      return ApiResponse(exception: OfflineException());
    } else {
      try {
        final result = await client.get(uri);
        return ApiResponse(data: _getProcessedResponse(result.body));
      } on SocketException catch (_) {
        return ApiResponse(exception: OfflineException());
      } on AppException catch (exception) {
        return ApiResponse(exception: exception);
      } on Exception catch (exception) {
        return ApiResponse(
          exception: FetchDataException(
            exception.toString(),
          ),
        );
      }
    }
  }

  String _mapRouteTypeToString(RouteType routeType) {
    switch (routeType) {
      case RouteType.allHeroes:
        return _Routes.allHeroes;
      case RouteType.heroInfo:
        return _Routes.heroInfo;
      case RouteType.heroPowerStats:
        return _Routes.heroPowerStats;
      case RouteType.heroAppearance:
        return _Routes.heroAppearance;
    }
  }

  dynamic _getProcessedResponse(String body) =>
      body.isNotEmpty ? json.decode(body) : null;
}
