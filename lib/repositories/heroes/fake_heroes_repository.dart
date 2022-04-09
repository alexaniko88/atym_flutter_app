import 'package:atym_flutter_app/core/api_response.dart';
import 'package:atym_flutter_app/data_models/hero_model.dart';
import 'package:atym_flutter_app/repositories/fake/assets_data_source.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/heroes_repository.dart';

class FakeHeroesRepository extends FakeRepository implements HeroesRepository {
  FakeHeroesRepository()
      : super(
          data: ConfigurationData(
            dataSourcePath: AssetsDataSource.heroesDataSource.getHeroes,
          ),
        );

  @override
  Future<ApiResponse<List<HeroModel>>> getAllHeroes() =>
      readFromPathByType<List<HeroModel>>(
        parser: (data) => List<HeroModel>.from(
          data.map((x) => HeroModel.fromJson(x)),
        ),
      );
}
