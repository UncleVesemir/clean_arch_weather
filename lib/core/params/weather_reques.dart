import 'package:clean_arch_weather/core/utils/constants.dart';

class WeatherRequestParams {
  final double lat;
  final double lon;
  final String appId;
  final String lang;
  final String units;

  WeatherRequestParams({
    required this.lat,
    required this.lon,
    this.appId = kAppId,
    this.lang = 'en',
    this.units = 'metric',
  });
}
