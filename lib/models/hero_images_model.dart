import 'package:json_annotation/json_annotation.dart';

part 'hero_images_model.g.dart';

@JsonSerializable()
class HeroImagesModel {
  final String? xs, sm, md, lg;

  const HeroImagesModel({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  factory HeroImagesModel.fromJson(Map<String, dynamic> json) =>
      _$HeroImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeroImagesModelToJson(this);
}
