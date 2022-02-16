part of 'remote_weather_bloc.dart';

abstract class RemoteWeatherEvent extends Equatable {
  const RemoteWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeather extends RemoteWeatherEvent {
  const GetWeather();
}
