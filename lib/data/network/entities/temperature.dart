import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

@JsonSerializable()
class Temperature {
  @JsonKey(name: 'day')
  final double day;

  @JsonKey(name: 'min')
  final double min;

  @JsonKey(name: 'max')
  final double max;

  @JsonKey(name: 'night')
  final double night;

  @JsonKey(name: 'eve')
  final double eve;

  @JsonKey(name: 'morn')
  final double morn;

  Temperature(
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  );

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}
