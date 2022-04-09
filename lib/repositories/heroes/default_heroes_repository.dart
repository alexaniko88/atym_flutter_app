import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/heroes_api.dart';
import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/data_models/hero_model.dart';
import 'package:atym_flutter_app/repositories/heroes/heroes_repository.dart';

class DefaultHeroesRepository implements HeroesRepository {
  final HeroesApi api;

  const DefaultHeroesRepository(this.api);

  @override
  Future<ApiResponse<List<HeroModel>>> getAllHeroes() async {
    final result = await api.get(RouteType.allHeroes);

    return result.isSuccess
        ? ApiResponse(
            data: List<HeroModel>.from(
              result.data.map((x) => HeroModel.fromJson(x)),
            ),
          )
        : ApiResponse(exception: result.exception ?? FetchDataException());
  }
}
