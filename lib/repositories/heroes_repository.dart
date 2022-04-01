import 'package:atym_flutter_app/core/api_response.dart';

abstract class HeroesRepository {
  Future<ApiResponse> getAllHeroes();
}