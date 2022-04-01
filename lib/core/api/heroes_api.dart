import 'package:atym_flutter_app/core/api_response.dart';

enum RouteType {
  allHeroes,
  heroInfo,
  heroPowerStats,
  heroAppearance,
}

abstract class HeroesApi {
  Future<ApiResponse> get(
    RouteType routeType, {
    String? heroId,
  });
}
