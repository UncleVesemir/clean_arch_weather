import 'package:clean_arch_weather/data/network/entities/weather_element.dart';
import 'package:clean_arch_weather/domain/model/current.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current.g.dart';

@JsonSerializable()
class CurrentModel extends Current {
  // @JsonKey(name: 'dt')
  // final int dt;

  // @JsonKey(name: 'temp')
  // final double temp;

  // @JsonKey(name: 'feels_like')
  // final double feelsLike;

  // @JsonKey(name: 'pressure')
  // final int pressure;

  // @JsonKey(name: 'humidity')
  // final int humidity;

  // @JsonKey(name: 'visibility')
  // final int visibility;

  // @JsonKey(name: 'wind_speed')
  // final double windSpeed;

  // @JsonKey(name: 'wind_deg')
  // final int windDeg;

  // @JsonKey(name: 'weather')
  // final List<WeatherElementModel> weather;

  const CurrentModel({
    required int dt,
    required double temp,
    required double feelsLike,
    required int pressure,
    required int humidity,
    required int visibility,
    required double windSpeed,
    required int windDeg,
    required List<WeatherElementModel> weather,
  }) : super(
          dt: dt,
          temp: temp,
          feelsLike: feelsLike,
          pressure: pressure,
          humidity: humidity,
          visibility: visibility,
          windSpeed: windSpeed,
          windDeg: windDeg,
          weather: weather,
        );

  factory CurrentModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentModelToJson(this);
}
