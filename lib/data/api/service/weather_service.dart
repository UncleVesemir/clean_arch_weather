import 'dart:developer';

import 'package:clean_arch_weather/data/api/request/get_day_weather_body.dart';
import 'package:clean_arch_weather/domain/model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherService {
  static const _APP_ID = 'appid=7aeb287065deb65dcdd0b7a08e8d6267';
  static const _UNITS = 'units=metric';
  static const _LANG = 'lang=en';
  static const _AND = '&';
  static const _LAT = 'lat=';
  static const _LON = 'lon=';
  static const _BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall?';

  static Future<Weather?> getDayWeather(GetDayBody body) async {
    final String finalUrl =
        '$_BASE_URL$_LAT${body.latitude}$_AND$_LON${body.longitude}$_AND$_APP_ID$_AND$_UNITS$_AND$_LANG';
    log(finalUrl);
    final response = await http.get(Uri.parse(finalUrl));
    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    } else {
      return null;
    }
  }
}
