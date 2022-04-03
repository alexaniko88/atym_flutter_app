import 'package:json_annotation/json_annotation.dart';

part 'power_stats_model.g.dart';

@JsonSerializable()
class PowerStatsModel {
  final int? intelligence, strength, speed, durability, power, combat;

  const PowerStatsModel({
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  });

  factory PowerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PowerStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PowerStatsModelToJson(this);
}
