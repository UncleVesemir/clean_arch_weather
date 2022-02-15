import 'package:clean_arch_weather/domain/model/current.dart';
import 'package:clean_arch_weather/domain/model/daily.dart';
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.lat,
    required this.lon,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final double lat;
  final double lon;
  final Current current;
  final List<Current> hourly;
  final List<Daily> daily;

  @override
  List<Object> get props {
    return [
      lat,
      lon,
      current,
      hourly,
      daily,
    ];
  }
}
