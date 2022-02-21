import 'package:clean_arch_weather/domain/usecases/get_weather_usecase.dart';
import 'package:clean_arch_weather/injector.dart';
import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:clean_arch_weather/presentation/views/home.dart';
import 'package:clean_arch_weather/styles_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteWeatherBloc>(
      create: (_) => injector()..add(const GetWeather()),
      child: MaterialApp(
        title: 'Weather',
        home: const Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            primaryColor: AppColors.mainLow,
            primaryColorDark: AppColors.mainLow,
            primaryColorLight: AppColors.mainLow,
            colorScheme: ColorScheme(
                primary: AppColors.mainLow,
                primaryVariant: AppColors.mainLow,
                secondary: AppColors.mainLow,
                secondaryVariant: AppColors.mainLow,
                surface: AppColors.mainLow,
                background: AppColors.mainLow,
                error: AppColors.mainLow,
                onPrimary: AppColors.mainLow,
                onSecondary: AppColors.mainLow,
                onSurface: AppColors.mainLow,
                onBackground: AppColors.mainLow,
                onError: AppColors.mainLow,
                brightness: Brightness.light)),
      ),
    );
  }
}
