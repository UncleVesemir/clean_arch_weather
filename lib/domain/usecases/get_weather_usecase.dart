import 'package:clean_arch_weather/core/params/weather_request.dart';
import 'package:clean_arch_weather/core/usecases/usecase.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/domain/repositories/weather_repository.dart';
import 'package:clean_arch_weather/core/resources/data_state.dart';

class GetWeatherUseCase
    implements UseCase<DataState<Weather>, WeatherRequestParams> {
  final WeatherRepository _weatherRepository;

  GetWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<Weather>> call({required WeatherRequestParams params}) {
    return _weatherRepository
        .getWeather(WeatherRequestParams(lat: params.lat, lon: params.lon));
  }
}
