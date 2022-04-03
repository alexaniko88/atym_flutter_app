import 'package:json_annotation/json_annotation.dart';

part 'biography_model.g.dart';

@JsonSerializable()
class BiographyModel {
  final String? fullName, alterEgos, placeOfBirth, firstAppearance, publisher, alignment;

  const BiographyModel({
    this.fullName,
    this.alterEgos,
    this.placeOfBirth,
    this.firstAppearance,
    this.alignment,
    this.publisher,
  });

  factory BiographyModel.fromJson(Map<String, dynamic> json) =>
      _$BiographyModelFromJson(json);

  Map<String, dynamic> toJson() => _$BiographyModelToJson(this);
}
