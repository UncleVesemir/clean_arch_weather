import 'package:clean_arch_weather/domain/entities/temperature.dart';

part 'temperature.g.dart';

// @JsonSerializable()
class TemperatureModel extends Temperature {
  // @JsonKey(name: 'day')
  // final double day;

  // @JsonKey(name: 'min')
  // final double min;

  // @JsonKey(name: 'max')
  // final double max;

  // @JsonKey(name: 'night')
  // final double night;

  // @JsonKey(name: 'eve')
  // final double eve;

  // @JsonKey(name: 'morn')
  // final double morn;

  const TemperatureModel({
    required double day,
    required double min,
    required double max,
    required double night,
    required double eve,
    required double morn,
  }) : super(
          day: day,
          min: min,
          max: max,
          night: night,
          eve: eve,
          morn: morn,
        );

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
}
