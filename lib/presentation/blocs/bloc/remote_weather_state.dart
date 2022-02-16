part of 'remote_weather_bloc.dart';

abstract class RemoteWeatherState extends Equatable {
  final Weather? weather;
  final DioError? error;
  const RemoteWeatherState({this.error, this.weather});

  @override
  List<Object> get props => [weather ?? '', error ?? ''];
}

class RemoteWeatherLoading extends RemoteWeatherState {
  const RemoteWeatherLoading();
}

class RemoteWeatherDone extends RemoteWeatherState {
  const RemoteWeatherDone({required Weather weather}) : super(weather: weather);
}

class RemoteWeatherError extends RemoteWeatherState {
  const RemoteWeatherError(DioError error) : super(error: error);
}
