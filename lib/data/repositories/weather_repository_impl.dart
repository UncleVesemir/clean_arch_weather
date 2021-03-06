import 'dart:io';

import 'package:clean_arch_weather/core/params/weather_request.dart';
import 'package:clean_arch_weather/core/resources/data_state.dart';
import 'package:clean_arch_weather/data/network/api_service.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/domain/repositories/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;

  const WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<DataState<Weather>> getWeather(WeatherRequestParams params) async {
    try {
      final httpResponse = await _weatherApiService.getWeather(
          params.lat, params.lon, params.appId, params.lang, params.units);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
