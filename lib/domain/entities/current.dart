import 'package:clean_arch_weather/domain/entities/weather_element.dart';
import 'package:equatable/equatable.dart';

class Current extends Equatable {
  const Current({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final List<WeatherElement> weather;

  @override
  List<Object> get props {
    return [
      dt,
      temp,
      feelsLike,
      pressure,
      humidity,
      visibility,
      windSpeed,
      windDeg,
      weather,
    ];
  }
}
