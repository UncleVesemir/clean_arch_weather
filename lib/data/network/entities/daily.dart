import 'package:clean_arch_weather/data/network/entities/temperature.dart';
import 'package:clean_arch_weather/data/network/entities/weather_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily.g.dart';

@JsonSerializable()
class Daily {
  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'temp')
  final Temperature temp;

  @JsonKey(name: 'pressure')
  final int pressure;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'wind_speed')
  final double windSpeed;

  @JsonKey(name: 'wind_deg')
  final int windDeg;

  @JsonKey(name: 'weather')
  final List<WeatherElement> weather;

  Daily(
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.windDeg,
    this.weather,
  );

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
