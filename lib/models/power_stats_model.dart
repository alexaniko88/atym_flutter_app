import 'package:json_annotation/json_annotation.dart';

part 'power_stats_model.g.dart';

@JsonSerializable()
class PowerStatsModel {
  final int? intelligence, strength, speed, durability, power, combat;

  const PowerStatsModel({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PowerStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PowerStatsModelToJson(this);
}
