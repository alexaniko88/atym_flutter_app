// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerStatsModel _$PowerStatsModelFromJson(Map<String, dynamic> json) =>
    PowerStatsModel(
      intelligence: json['intelligence'] as int?,
      strength: json['strength'] as int?,
      speed: json['speed'] as int?,
      durability: json['durability'] as int?,
      power: json['power'] as int?,
      combat: json['combat'] as int?,
    );

Map<String, dynamic> _$PowerStatsModelToJson(PowerStatsModel instance) =>
    <String, dynamic>{
      'intelligence': instance.intelligence,
      'strength': instance.strength,
      'speed': instance.speed,
      'durability': instance.durability,
      'power': instance.power,
      'combat': instance.combat,
    };
