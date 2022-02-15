import 'package:clean_arch_weather/data/network/response/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/onecall?')
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      contentType: 'application/json',
    );

    return _ApiService(dio, baseUrl: baseUrl);
  }

  // Login service
  @GET('') // enter your api method
  Future<WeatherResponse> getWeather(
    @Query('lat') double lat,
    @Query('lon') double lon,
    @Query('appid') String appId,
    @Query('lang') String lang,
    @Query('units') String units,
  );
}
