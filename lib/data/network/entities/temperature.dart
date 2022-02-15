import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

@JsonSerializable()
class TemperatureModel {
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

  TemperatureModel(
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  );

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
}
