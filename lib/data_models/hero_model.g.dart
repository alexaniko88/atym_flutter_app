// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeroModel _$HeroModelFromJson(Map<String, dynamic> json) => HeroModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      appearanceModel: json['appearance'] == null
          ? null
          : AppearanceModel.fromJson(
              json['appearance'] as Map<String, dynamic>),
      powerStatsModel: json['powerstats'] == null
          ? null
          : PowerStatsModel.fromJson(
              json['powerstats'] as Map<String, dynamic>),
      heroImagesModel: json['images'] == null
          ? null
          : HeroImagesModel.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeroModelToJson(HeroModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'appearance': instance.appearanceModel,
      'powerstats': instance.powerStatsModel,
      'images': instance.heroImagesModel,
    };
