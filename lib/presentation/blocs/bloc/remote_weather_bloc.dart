import 'package:bloc/bloc.dart';
import 'package:clean_arch_weather/core/bloc/bloc_with_state.dart';
import 'package:clean_arch_weather/core/params/weather_reques.dart';
import 'package:clean_arch_weather/core/resources/data_state.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/domain/usecases/get_weather_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_weather_event.dart';
part 'remote_weather_state.dart';

class RemoteWeatherBloc
    extends BlocWithState<RemoteWeatherEvent, RemoteWeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  RemoteWeatherBloc(this._getWeatherUseCase)
      : super(const RemoteWeatherLoading());

  Weather? weather;

  @override
  Stream<RemoteWeatherState> mapEventToState(RemoteWeatherEvent event) async* {
    if (event is GetWeather) yield* _getWeather(event);
  }

  Stream<RemoteWeatherState> _getWeather(RemoteWeatherEvent event) async* {
    yield* runBlocProcess(() async* {
      final dataState = await _getWeatherUseCase(
          params: WeatherRequestParams(lat: 32, lon: 43));

      if (dataState is DataSuccess && dataState.data != null) {
        final weather = dataState.data!;
        yield RemoteWeatherDone(weather: weather);
      }
      if (dataState is DataFailed) {
        yield RemoteWeatherError(dataState.error!);
      }
    });
  }
}
