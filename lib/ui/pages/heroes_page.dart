import 'package:atym_flutter_app/constants.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/heroes_repository.dart';
import 'package:atym_flutter_app/ui/builders/cubit_with_connectivity_wrapper_builder.dart';
import 'package:atym_flutter_app/ui/widgets/language_switcher_icon.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroesPage extends StatelessWidget {
  const HeroesPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) =>
            HeroesCubit(context.read<HeroesRepository>())..getHeroes(),
        child: HeroesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).heroesPage),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [LanguageSwitcherIcon()],
      ),
      body:
          CubitWithConnectivityWrapperBuilder<HeroesCubit, List<HeroViewModel>>(
        bloc: context.watch<HeroesCubit>(),
        listener: (_, current) {},
        builder: (context, bloc, data, isOnline) {
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: item.imageURL,
                      width: leadingImageWidth,
                    ),
                    title: Text(item.name ?? notAvailable),
                    subtitle: Text(item.fullName ?? notAvailable),
                    trailing: SizedBox(
                      width: heroListTileTrailingWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context).speed}: '
                            '${item.speed}',
                          ),
                          Text(
                            '${AppLocalizations.of(context).power}: '
                            '${item.power}',
                          ),
                          Text(
                            '${AppLocalizations.of(context).strength}: '
                            '${item.strength}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
