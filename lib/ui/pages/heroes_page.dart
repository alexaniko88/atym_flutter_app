import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/repositories/heroes_repository.dart';
import 'package:atym_flutter_app/ui/builders/cubit_builder_with_connectivity_wrapper.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('Heroes Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:
          CubitBuilderWithConnectivityWrapper<HeroesCubit, List<HeroViewModel>>(
        bloc: context.watch<HeroesCubit>(),
        listener: (_, current) {},
        builder: (context, bloc, data, isOnline) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: item.imageURL,
                      width: 50,
                    ),
                    title: Text(item.name ?? 'N/A'),
                    subtitle: Text(item.gender ?? 'N/A'),
                    trailing: Column(
                      children: [
                        Text('Speed: ${item.speed}'),
                        Text('Power: ${item.power}'),
                        Text('Strength: ${item.strength}'),
                      ],
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
