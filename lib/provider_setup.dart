import 'package:atym_flutter_app/core/api/default_heroes_api.dart';
import 'package:atym_flutter_app/core/api/heroes_api.dart';
import 'package:atym_flutter_app/core/http_client/default_http_client.dart';
import 'package:atym_flutter_app/core/http_client/http_client.dart';
import 'package:atym_flutter_app/repositories/default_heroes_repository.dart';
import 'package:atym_flutter_app/repositories/heroes_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ...clients,
  ...apis,
  ...repositories,
];

final List<SingleChildWidget> clients = [
  Provider<HttpClient>(
    create: (context) => DefaultHttpClient(),
  ),
];

final List<SingleChildWidget> apis = [
  ProxyProvider<HttpClient, HeroesApi>(
    update: (context, client, api) => DefaultHeroesApi(client),
  ),
];

final List<SingleChildWidget> repositories = [
  ProxyProvider<HeroesApi, HeroesRepository>(
    update: (context, api, _) => DefaultHeroesRepository(api),
  ),
];
