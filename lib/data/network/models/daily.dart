import 'package:clean_arch_weather/data/network/models/temperature.dart';
import 'package:clean_arch_weather/data/network/models/weather_element.dart';
import 'package:clean_arch_weather/domain/entities/daily.dart';

part 'daily.g.dart';

// @JsonSerializable()
class DailyModel extends Daily {
  // @JsonKey(name: 'dt')
  // final int dt;

  // @JsonKey(name: 'temp')
  // final TemperatureModel temp;

  // @JsonKey(name: 'pressure')
  // final int pressure;

  // @JsonKey(name: 'humidity')
  // final int humidity;

  // @JsonKey(name: 'wind_speed')
  // final double windSpeed;

  // @JsonKey(name: 'wind_deg')
  // final int windDeg;

  // @JsonKey(name: 'weather')
  // final List<WeatherElementModel> weather;

  const DailyModel({
    required int dt,
    required TemperatureModel temp,
    required int pressure,
    required int humidity,
    required double windSpeed,
    required int windDeg,
    required List<WeatherElementModel> weather,
  }) : super(
          dt: dt,
          temp: temp,
          pressure: pressure,
          humidity: humidity,
          windSpeed: windSpeed,
          windDeg: windDeg,
          weather: weather,
        );

  factory DailyModel.fromJson(Map<String, dynamic> json) =>
      _$DailyModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyModelToJson(this);
}
