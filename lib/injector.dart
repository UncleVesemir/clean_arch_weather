import 'package:clean_arch_weather/data/network/api_service.dart';
import 'package:clean_arch_weather/data/repositories/weather_repository_impl.dart';
import 'package:clean_arch_weather/domain/repositories/weather_repository.dart';
import 'package:clean_arch_weather/domain/usecases/get_weather_usecase.dart';
import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //DIO CLIENT
  injector.registerSingleton<Dio>(Dio());

  //DEPENDENCIES
  injector.registerSingleton<WeatherApiService>(WeatherApiService(injector()));
  injector
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(injector()));

  //USECASES
  injector.registerSingleton<GetWeatherUseCase>(GetWeatherUseCase(injector()));

  //BLOCS
  injector
      .registerFactory<RemoteWeatherBloc>(() => RemoteWeatherBloc(injector()));
}
