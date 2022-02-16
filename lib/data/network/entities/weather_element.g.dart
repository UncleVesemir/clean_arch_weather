part of 'weather_element.dart';

WeatherElementModel _$WeatherElementModelFromJson(Map<String, dynamic> json) =>
    WeatherElementModel(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$WeatherElementModelToJson(
        WeatherElementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
    };
