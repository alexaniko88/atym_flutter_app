import 'package:json_annotation/json_annotation.dart';

part 'hero_images_model.g.dart';

@JsonSerializable()
class HeroImagesModel {
  final String? xs, sm, md, lg;

  const HeroImagesModel({
    this.xs,
    this.sm,
    this.md,
    this.lg,
  });

  factory HeroImagesModel.fromJson(Map<String, dynamic> json) =>
      _$HeroImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeroImagesModelToJson(this);
}
