import 'package:atym_flutter_app/constants.dart';
import 'package:atym_flutter_app/extensions/int_extensions.dart';
import 'package:atym_flutter_app/ui/widgets/avatar_view.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class _Constants {
  static const double cardElevation = 10;
  static const double totalStats = 6;
  static const double avatarSpreadRadius = 5;
  static const double avatarBlurRadius = 5;

  static const int maxRange = 100;
  static const int greenRangeEnd = 80;
  static const int blueRangeEnd = 60;
  static const int yellowRangeEnd = 40;
  static const int orangeRangeEnd = 20;
}

class HeroDetailsPage extends StatelessWidget {
  final HeroViewModel heroViewModel;

  const HeroDetailsPage({
    Key? key,
    required this.heroViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          elevation: _Constants.cardElevation,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Hero(
                    tag: heroViewModel.key.toString(),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: _getAverageColorFromStats(),
                            spreadRadius: _Constants.avatarSpreadRadius,
                            blurRadius: _Constants.avatarBlurRadius,
                          ),
                        ],
                      ),
                      child: AvatarView(
                        url: heroViewModel.imageURL,
                        width: heroDetailsImageWidth,
                        useDecoration: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Text(
                    heroViewModel.fullName.isNotEmpty
                        ? heroViewModel.fullName
                        : heroViewModel.name,
                    style: Get.theme.textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding * 3),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).power,
                              stat: heroViewModel.power,
                            ),
                          ),
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).speed,
                              stat: heroViewModel.speed,
                              left: false,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).strength,
                              stat: heroViewModel.strength,
                            ),
                          ),
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).intelligence,
                              stat: heroViewModel.intelligence,
                              left: false,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).durability,
                              stat: heroViewModel.durability,
                            ),
                          ),
                          Builder(
                            builder: (context) => _buildStatistic(
                              label: AppLocalizations.of(context).combat,
                              stat: heroViewModel.combat,
                              left: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatistic({
    required String label,
    required int stat,
    bool left = true,
  }) {
    return Expanded(
      child: Container(
        decoration: left
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: left
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(left: defaultPadding),
              child: Text(
                label + ':',
                style: Get.theme.textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: defaultPadding,
              ),
              child: Text(
                stat.toString(),
                style: Get.theme.textTheme.subtitle1?.copyWith(
                  color: _getColorByStat(stat),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAverageColorFromStats() {
    final totalStats = heroViewModel.strength +
        heroViewModel.speed +
        heroViewModel.intelligence +
        heroViewModel.durability +
        heroViewModel.combat +
        heroViewModel.power;
    return _getColorByStat(
      (totalStats / _Constants.totalStats).truncate(),
    );
  }

  Color _getColorByStat(int stat) {
    if (stat.isBetween(
      from: _Constants.maxRange,
      to: _Constants.greenRangeEnd,
    )) {
      return Colors.green;
    } else if (stat.isBetween(
      from: _Constants.greenRangeEnd,
      to: _Constants.blueRangeEnd,
    )) {
      return Colors.blue;
    } else if (stat.isBetween(
      from: _Constants.blueRangeEnd,
      to: _Constants.yellowRangeEnd,
    )) {
      return Colors.yellow;
    } else if (stat.isBetween(
      from: _Constants.yellowRangeEnd,
      to: _Constants.orangeRangeEnd,
    )) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
