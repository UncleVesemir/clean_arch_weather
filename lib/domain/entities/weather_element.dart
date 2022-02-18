import 'package:clean_arch_weather/data/network/models/weather_element.dart';
import 'package:equatable/equatable.dart';

class WeatherElement extends Equatable {
  const WeatherElement({
    required this.id,
    required this.main,
    required this.description,
    required this.image,
  });

  final int id;
  final Main main;
  final String description;
  final String image;

  @override
  List<Object> get props {
    return [
      id,
      main,
      description,
    ];
  }
}
