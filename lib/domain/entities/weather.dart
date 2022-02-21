import 'package:clean_arch_weather/domain/entities/current.dart';
import 'package:clean_arch_weather/domain/entities/daily.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

class Weather extends Equatable {
  const Weather({
    required this.lat,
    required this.lon,
    this.place,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final double lat;
  final double lon;
  final List<Placemark?>? place;
  final Current current;
  final List<Current> hourly;
  final List<Daily> daily;

  @override
  List<Object> get props {
    return [
      lat,
      lon,
      daily,
      current,
      hourly,
    ];
  }
}
