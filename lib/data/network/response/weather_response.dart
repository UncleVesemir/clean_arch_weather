import 'package:clean_arch_weather/data/network/models/current.dart';
import 'package:clean_arch_weather/data/network/models/daily.dart';
import 'package:clean_arch_weather/domain/entities/current.dart';
import 'package:clean_arch_weather/domain/entities/daily.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:geocoding/geocoding.dart';

part 'weather_response.g.dart';

// @JsonSerializable()
class WeatherResponse extends Weather {
  // @JsonKey(name: 'lat')
  // final double lat;

  // @JsonKey(name: 'lon')
  // final double lon;

  // @JsonKey(name: 'current')
  // final CurrentModel current;

  // @JsonKey(name: 'hourly')
  // final List<CurrentModel> hourly;

  // @JsonKey(name: 'daily')
  // final List<DailyModel> daily;

  const WeatherResponse({
    required double lat,
    required double lon,
    required Current current,
    required List<Current> hourly,
    required List<Daily> daily,
    List<Placemark?>? place,
  }) : super(
          lat: lat,
          lon: lon,
          current: current,
          hourly: hourly,
          daily: daily,
          place: place,
        );

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
