import 'package:clean_arch_weather/domain/usecases/get_weather_usecase.dart';
import 'package:clean_arch_weather/injector.dart';
import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:clean_arch_weather/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteWeatherBloc>(
      create: (_) => injector()..add(GetWeather()),
      child: const MaterialApp(
        title: 'Weather',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
