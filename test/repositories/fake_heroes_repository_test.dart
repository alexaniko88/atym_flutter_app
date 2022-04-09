import 'package:atym_flutter_app/repositories/heroes/fake_heroes_repository.dart';
import 'package:atym_flutter_app/repositories/heroes/heroes_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final HeroesRepository repository;

  setUpAll(() {
    repository = FakeHeroesRepository();
  });

  group('Fake Heroes Repository test ', () {
    test('call getAllHeroes and receive the correct result', () async {
      final result = await repository.getAllHeroes();

      expect(result.isSuccess, true);
      expect(result.exception, isNull);
      expect(result.data, isNotEmpty);
    });
  });
}
