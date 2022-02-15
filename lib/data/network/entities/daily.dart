import 'package:clean_arch_weather/data/network/entities/temperature.dart';
import 'package:clean_arch_weather/data/network/entities/weather_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily.g.dart';

@JsonSerializable()
class DailyModel {
  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'temp')
  final TemperatureModel temp;

  @JsonKey(name: 'pressure')
  final int pressure;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'wind_speed')
  final double windSpeed;

  @JsonKey(name: 'wind_deg')
  final int windDeg;

  @JsonKey(name: 'weather')
  final List<WeatherElementModel> weather;

  DailyModel(
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.windDeg,
    this.weather,
  );

  factory DailyModel.fromJson(Map<String, dynamic> json) =>
      _$DailyModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyModelToJson(this);
}
