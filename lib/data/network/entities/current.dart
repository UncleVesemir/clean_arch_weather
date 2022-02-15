import 'package:clean_arch_weather/data/network/entities/weather_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current.g.dart';

@JsonSerializable()
class CurrentModel {
  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'temp')
  final double temp;

  @JsonKey(name: 'feels_like')
  final double feelsLike;

  @JsonKey(name: 'pressure')
  final int pressure;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'visibility')
  final int visibility;

  @JsonKey(name: 'wind_speed')
  final double windSpeed;

  @JsonKey(name: 'wind_deg')
  final int windDeg;

  @JsonKey(name: 'weather')
  final List<WeatherElementModel> weather;

  CurrentModel(
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
  );

  factory CurrentModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentModelToJson(this);
}
