import 'package:atym_flutter_app/data_models/hero_model.dart';
import 'package:flutter/material.dart';

class HeroViewModel {
  final Key? key;
  final String imageURL;
  final String name, fullName;
  final int intelligence, strength, speed, durability, power, combat;

  const HeroViewModel({
    required this.imageURL,
    required this.name,
    required this.fullName,
    this.key,
    int? intelligence,
    int? strength,
    int? speed,
    int? durability,
    int? power,
    int? combat,
  })  : this.intelligence = intelligence ?? 0,
        this.strength = strength ?? 0,
        this.speed = speed ?? 0,
        this.durability = durability ?? 0,
        this.power = power ?? 0,
        this.combat = combat ?? 0;

  factory HeroViewModel.fromDataModel(HeroModel heroModel) => HeroViewModel(
        key: UniqueKey(),
        imageURL: heroModel.heroImagesModel?.sm ?? '',
        name: heroModel.name ?? '',
        fullName: heroModel.biographyModel?.fullName ?? '',
        combat: heroModel.powerStatsModel?.combat,
        durability: heroModel.powerStatsModel?.durability,
        intelligence: heroModel.powerStatsModel?.intelligence,
        power: heroModel.powerStatsModel?.power,
        speed: heroModel.powerStatsModel?.speed,
        strength: heroModel.powerStatsModel?.strength,
      );
}
