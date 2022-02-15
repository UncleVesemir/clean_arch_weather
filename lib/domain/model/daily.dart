import 'package:clean_arch_weather/domain/model/temperature.dart';
import 'package:clean_arch_weather/domain/model/weather_element.dart';
import 'package:equatable/equatable.dart';

class Daily extends Equatable {
  const Daily({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  final int dt;
  final Temperature temp;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final List<WeatherElement> weather;

  @override
  List<Object?> get props {
    return [
      dt,
      temp,
      pressure,
      humidity,
      windSpeed,
      windDeg,
      weather,
    ];
  }
}
