import 'package:json_annotation/json_annotation.dart';

part 'weather_element.g.dart';

@JsonSerializable()
class WeatherElementModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'main')
  final String main;

  @JsonKey(name: 'description')
  final String description;

  WeatherElementModel(this.id, this.main, this.description);

  factory WeatherElementModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherElementModelToJson(this);
}
