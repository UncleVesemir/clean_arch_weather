import 'package:clean_arch_weather/core/params/weather_request.dart';
import 'package:clean_arch_weather/core/resources/data_state.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<DataState<Weather>> getWeather(WeatherRequestParams params);
}
