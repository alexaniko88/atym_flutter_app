import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/data_models/hero_model.dart';

abstract class HeroesRepository {
  Future<ApiResponse<List<HeroModel>>> getAllHeroes();
}