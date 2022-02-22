import 'package:clean_arch_weather/core/bloc/bloc_with_state.dart';
import 'package:clean_arch_weather/core/params/weather_request.dart';
import 'package:clean_arch_weather/core/resources/data_state.dart';
import 'package:clean_arch_weather/domain/entities/location.dart';
import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/domain/usecases/get_weather_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

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

  Future<CurrentLocation?> _getLocation() async {
    final location = await _getPermission();
    if (location != null) {
      try {
        var curLocation = await location.getLocation();
        return CurrentLocation(
            lat: curLocation.latitude!, lon: curLocation.longitude!);
      } catch (e) {
        return null;
      }
    }
  }

  Future<Location?> _getPermission() async {
    var location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location;
  }

  Future<void> _getWeather(RemoteWeatherEvent event) async {
    final CurrentLocation? location = await _getLocation();
    List<geo.Placemark> placemarks = [];
    if (location != null) {
      final dataState = await _getWeatherUseCase(
          params: WeatherRequestParams(lat: location.lat, lon: location.lon));

      try {
        placemarks = await geo.placemarkFromCoordinates(
            location.lat, location.lon,
            localeIdentifier: 'en');
        print(placemarks);
      } catch (e) {
        print(e);
      }

      print('lat - ${dataState.data!.lat} lon - ${dataState.data!.lon}');

      if (dataState is DataSuccess && dataState.data != null) {
        var weather = dataState.data!;
        if (placemarks.isNotEmpty) {
          var result = Weather(
            current: weather.current,
            daily: weather.daily,
            lat: weather.lat,
            lon: weather.lon,
            hourly: weather.hourly,
            place: placemarks,
          );
          emit(RemoteWeatherDone(weather: result));
        } else {
          emit(RemoteWeatherDone(weather: weather));
        }
      }
      if (dataState is DataFailed) {
        emit(RemoteWeatherError(dataState.error!));
      }
    } else {
      Future.delayed(const Duration(milliseconds: 100));
      _getWeather(event);
    }
  }
}
