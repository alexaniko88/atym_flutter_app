import 'package:atym_flutter_app/data_models/appearance_model.dart';
import 'package:atym_flutter_app/data_models/biography_model.dart';
import 'package:atym_flutter_app/data_models/hero_images_model.dart';
import 'package:atym_flutter_app/data_models/power_stats_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hero_model.g.dart';

@JsonSerializable()
class HeroModel {
  final int? id;
  final String? name, slug;
  @JsonKey(name: 'appearance')
  final AppearanceModel? appearanceModel;
  @JsonKey(name: 'biography')
  final BiographyModel? biographyModel;
  @JsonKey(name: 'powerstats')
  final PowerStatsModel? powerStatsModel;
  @JsonKey(name: 'images')
  final HeroImagesModel? heroImagesModel;

  const HeroModel({
    this.id,
    this.name,
    this.slug,
    this.appearanceModel,
    this.powerStatsModel,
    this.heroImagesModel,
    this.biographyModel,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) =>
      _$HeroModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeroModelToJson(this);
}
