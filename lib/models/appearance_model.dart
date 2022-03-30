import 'package:json_annotation/json_annotation.dart';

part 'appearance_model.g.dart';

@JsonSerializable()
class AppearanceModel {
  final String? gender, race, eyeColor, hairColor;

  const AppearanceModel({
    required this.gender,
    required this.race,
    required this.eyeColor,
    required this.hairColor,
  });

  factory AppearanceModel.fromJson(Map<String, dynamic> json) =>
      _$AppearanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppearanceModelToJson(this);
}
