import 'package:clean_arch_weather/core/utils/constants.dart';
import 'package:clean_arch_weather/data/network/response/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      contentType: 'application/json',
    );

    return _ApiService(dio, baseUrl: baseUrl);
  }

  // Login service
  @GET('')
  Future<HttpResponse<WeatherResponse>> getWeather(
    @Query('lat') double lat,
    @Query('lon') double lon,
    @Query('appid') String appId,
    @Query('lang') String lang,
    @Query('units') String units,
  );
}
