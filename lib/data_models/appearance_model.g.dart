// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppearanceModel _$AppearanceModelFromJson(Map<String, dynamic> json) =>
    AppearanceModel(
      gender: json['gender'] as String?,
      race: json['race'] as String?,
      eyeColor: json['eyeColor'] as String?,
      hairColor: json['hairColor'] as String?,
    );

Map<String, dynamic> _$AppearanceModelToJson(AppearanceModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'race': instance.race,
      'eyeColor': instance.eyeColor,
      'hairColor': instance.hairColor,
    };
