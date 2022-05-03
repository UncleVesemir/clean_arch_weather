import 'package:floor/floor.dart';

import '../../domain/entities/weather.dart';

class WeatherTypeConverter
    extends TypeConverter<Weather, Map<String, dynamic>> {
  @override
  Weather decode(Map<String, dynamic> databaseValue) {
    return Weather.fromJson(databaseValue);
  }

  @override
  Map<String, dynamic> encode(Weather value) {
    return value.toJson();
  }
}
