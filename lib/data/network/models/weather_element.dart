import 'package:clean_arch_weather/domain/entities/other.dart';
import 'package:clean_arch_weather/domain/entities/weather_element.dart';
import 'package:clean_arch_weather/styles_const.dart';

part 'weather_element.g.dart';

// @JsonSerializable()
class WeatherElementModel extends WeatherElement {
  // @JsonKey(name: 'id')
  // final int id;

  // @JsonKey(name: 'main')
  // final String main;

  // @JsonKey(name: 'description')
  // final String description;

  const WeatherElementModel({
    required int id,
    required Main main,
    required String description,
    required String image,
  }) : super(
          id: id,
          main: main,
          description: description,
          image: image,
        );

  factory WeatherElementModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherElementModelToJson(this);
}
