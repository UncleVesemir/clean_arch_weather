import 'package:json_annotation/json_annotation.dart';

part 'weather_element.g.dart';

@JsonSerializable()
class WeatherElement {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'main')
  final String main;

  @JsonKey(name: 'description')
  final String description;

  WeatherElement(this.id, this.main, this.description);

  factory WeatherElement.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherElementToJson(this);
}
