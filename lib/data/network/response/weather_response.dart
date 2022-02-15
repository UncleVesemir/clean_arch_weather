import 'package:clean_arch_weather/data/network/entities/current.dart';
import 'package:clean_arch_weather/data/network/entities/daily.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'lon')
  final double lon;

  @JsonKey(name: 'current')
  final Current current;

  @JsonKey(name: 'hourly')
  final List<Current> hourly;

  @JsonKey(name: 'daily')
  final List<Daily> daily;

  WeatherResponse(
    this.lat,
    this.lon,
    this.current,
    this.hourly,
    this.daily,
  );

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
