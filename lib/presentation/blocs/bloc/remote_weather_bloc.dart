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
      : super(const RemoteWeatherLoading()) {
    on<RemoteWeatherEvent>((event, emit) async {
      await _getWeather(event);
    });
  }

  Weather? weather;

  // @override
  // Future<void> mapEventToState(RemoteWeatherEvent event) async {
  //   if (event is GetWeather) {
  //     _getWeather(event);
  //   }
  // }

  Future<void> _getWeather(RemoteWeatherEvent event) async {
    final dataState = await _getWeatherUseCase(
        params: WeatherRequestParams(lat: 32, lon: 43));

    if (dataState is DataSuccess && dataState.data != null) {
      final weather = dataState.data!;
      emit(RemoteWeatherDone(weather: weather));
    }
    if (dataState is DataFailed) {
      emit(RemoteWeatherError(dataState.error!));
    }
  }
}
