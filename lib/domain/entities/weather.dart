import 'package:clean_arch_weather/core/utils/constants.dart';
import 'package:clean_arch_weather/domain/entities/current.dart';
import 'package:clean_arch_weather/domain/entities/daily.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:geocoding/geocoding.dart';

import '../../data/network/models/current.dart';
import '../../data/network/models/daily.dart';

@Entity(tableName: kWeatherTableName)
class Weather extends Equatable {
  const Weather({
    @PrimaryKey(autoGenerate: true) this.id,
    required this.lat,
    required this.lon,
    this.place,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final int? id;
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

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      current: CurrentModel.fromJson(json['current'] as Map<String, dynamic>),
      hourly: (json['hourly'] as List<dynamic>)
          .map((e) => CurrentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      daily: (json['daily'] as List<dynamic>)
          .map((e) => DailyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'current': instance.current,
      'hourly': instance.hourly,
      'daily': instance.daily,
    };
