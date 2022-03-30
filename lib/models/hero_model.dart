import 'package:atym_flutter_app/models/appearance_model.dart';
import 'package:atym_flutter_app/models/hero_images_model.dart';
import 'package:atym_flutter_app/models/power_stats_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hero_model.g.dart';

@JsonSerializable()
class HeroModel {
  final int? id;
  final String? name, slug;
  @JsonKey(name: 'appearance')
  final AppearanceModel? appearanceModel;
  @JsonKey(name: 'powerstats')
  final PowerStatsModel? powerStatsModel;
  @JsonKey(name: 'images')
  final HeroImagesModel? heroImagesModel;

  const HeroModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.appearanceModel,
    required this.powerStatsModel,
    required this.heroImagesModel,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) =>
      _$HeroModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeroModelToJson(this);
}
