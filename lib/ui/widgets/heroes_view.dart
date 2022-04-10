import 'package:atym_flutter_app/constants.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/ui/builders/cubit_with_connectivity_wrapper_builder.dart';
import 'package:atym_flutter_app/ui/pages/hero_details_page.dart';
import 'package:atym_flutter_app/ui/widgets/avatar_view.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart' as get_navigation;

class _Constants {
  static const Duration animationDuration = Duration(milliseconds: 500);
}

class HeroesView extends StatelessWidget {
  const HeroesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitWithConnectivityWrapperBuilder<HeroesCubit,
        List<HeroViewModel>>(
      cubit: context.watch<HeroesCubit>(),
      listener: (_, current) {},
      connectivityListenerCallback: (context, cubit, isOnline) => _refresh(
        cubit: cubit,
        isOnline: isOnline,
      ),
      builder: (context, bloc, data, isOnline) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          padding: const EdgeInsets.all(defaultPadding),
          itemBuilder: (context, index) {
            final item = data[index];
            return Card(
              child: ListTile(
                leading: Hero(
                  tag: item.key.toString(),
                  child: AvatarView(
                    url: item.imageURL,
                    width: leadingImageSize,
                  ),
                ),
                title: Text(item.name),
                subtitle: Text(item.fullName),
                trailing: Text(item.publisher),
                onTap: () => Get.to(
                  HeroDetailsPage(
                    heroViewModel: item,
                  ),
                  opaque: false,
                  transition: get_navigation.Transition.zoom,
                  duration: _Constants.animationDuration,
                  fullscreenDialog: true,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future _refresh({
    required HeroesCubit cubit,
    required bool isOnline,
  }) async {
    if (isOnline) {
      await cubit.getHeroes();
    }
  }
}
