// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biography_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiographyModel _$BiographyModelFromJson(Map<String, dynamic> json) =>
    BiographyModel(
      fullName: json['fullName'] as String?,
      alterEgos: json['alterEgos'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      firstAppearance: json['firstAppearance'] as String?,
      alignment: json['alignment'] as String?,
      publisher: json['publisher'] as String?,
    );

Map<String, dynamic> _$BiographyModelToJson(BiographyModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'alterEgos': instance.alterEgos,
      'placeOfBirth': instance.placeOfBirth,
      'firstAppearance': instance.firstAppearance,
      'publisher': instance.publisher,
      'alignment': instance.alignment,
    };
