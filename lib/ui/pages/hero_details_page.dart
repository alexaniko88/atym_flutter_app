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

  static const int redRangeStart = 0;
  static const int orangeRangeStart = 20;
  static const int yellowRangeStart = 40;
  static const int blueRangeStart = 60;
  static const int greenRangeStart = 80;
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
      from: _Constants.redRangeStart,
      to: _Constants.orangeRangeStart,
    )) {
      return Colors.red;
    } else if (stat.isBetween(
      from: _Constants.orangeRangeStart,
      to: _Constants.yellowRangeStart,
    )) {
      return Colors.orange;
    } else if (stat.isBetween(
      from: _Constants.yellowRangeStart,
      to: _Constants.blueRangeStart,
    )) {
      return Colors.yellow;
    } else if (stat.isBetween(
      from: _Constants.blueRangeStart,
      to: _Constants.greenRangeStart,
    )) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}
