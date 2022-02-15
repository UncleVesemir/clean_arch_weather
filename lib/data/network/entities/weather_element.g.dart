// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherElementModel _$WeatherElementModelFromJson(Map<String, dynamic> json) =>
    WeatherElementModel(
      json['id'] as int,
      json['main'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$WeatherElementModelToJson(
        WeatherElementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
    };
