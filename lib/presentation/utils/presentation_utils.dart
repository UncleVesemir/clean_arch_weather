import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:clean_arch_weather/styles_const.dart';
import 'package:flutter/material.dart';

class PresentationUtils {
  static String getWeekdayName(int num) {
    switch (num) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'error';
    }
  }

  static String getFormattedTemperatureData(double x, double y) {
    final date = DateTime.fromMillisecondsSinceEpoch(x.toInt() * 1000);
    var minutes = date.minute;
    var minutesToStr = '';
    if (minutes < 10) {
      minutesToStr = '0$minutes';
    } else {
      minutesToStr = minutes.toString();
    }
    final month = getMonthName(date.month);
    final weekDay = getWeekdayName(date.weekday);
    return '$month ${date.day}, $weekDay, ${date.hour}:$minutesToStr, $y°C';
  }

  static String getFormattedWindSpeedData(double x, double y) {
    final date = DateTime.fromMillisecondsSinceEpoch(x.toInt() * 1000);
    var minutes = date.minute;
    var minutesToStr = '';
    if (minutes < 10) {
      minutesToStr = '0$minutes';
    } else {
      minutesToStr = minutes.toString();
    }
    final month = getMonthName(date.month);
    final weekDay = getWeekdayName(date.weekday);
    return '$month ${date.day}, $weekDay, ${date.hour}:$minutesToStr, $y m/s';
  }

  static String getFormattedWindDegData(double x, double y) {
    final date = DateTime.fromMillisecondsSinceEpoch(x.toInt() * 1000);
    var minutes = date.minute;
    var minutesToStr = '';
    if (minutes < 10) {
      minutesToStr = '0$minutes';
    } else {
      minutesToStr = minutes.toString();
    }
    final month = getMonthName(date.month);
    final weekDay = getWeekdayName(date.weekday);
    var windDeg = '';
    if (y > 22.5 && y <= 67.5) windDeg = 'North-East';
    if (y > 67.5 && y <= 112.5) windDeg = 'East';
    if (y > 112.5 && y <= 157.5) windDeg = 'South-East';
    if (y > 202.5 && y <= 247.5) windDeg = 'South';
    if (y > 157.5 && y <= 202.5) windDeg = 'South-West';
    if (y > 247.5 && y <= 292.5) windDeg = 'West';
    if (y > 292.5 && y <= 337.5) windDeg = 'North-West';
    if (y > 337.5 || y <= 22.5) windDeg = 'North';
    return '$month ${date.day}, $weekDay, ${date.hour}:$minutesToStr, $windDeg';
  }

  static String getFormattedHumidityData(double x, double y) {
    final date = DateTime.fromMillisecondsSinceEpoch(x.toInt() * 1000);
    var minutes = date.minute;
    var minutesToStr = '';
    if (minutes < 10) {
      minutesToStr = '0$minutes';
    } else {
      minutesToStr = minutes.toString();
    }
    final month = getMonthName(date.month);
    final weekDay = getWeekdayName(date.weekday);
    return '$month ${date.day}, $weekDay, ${date.hour}:$minutesToStr, $y%';
  }

  static String getDateTimePeriodHourly(RemoteWeatherState state) {
    final fD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.hourly.first.dt.toInt() * 1000);
    final sD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.hourly.last.dt.toInt() * 1000);
    return '${getMonthName(fD.month)} ${fD.day} - ${getMonthName(sD.month)} ${sD.day}';
  }

  static String getDateTimePeriodDaily(RemoteWeatherState state) {
    final fD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.daily.first.dt.toInt() * 1000);
    final sD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.daily.last.dt.toInt() * 1000);
    return '${getMonthName(fD.month)} ${fD.day} - ${getMonthName(sD.month)} ${sD.day}';
  }

  static String toUpperCase(String value) {
    String result = '';
    for (var i = 0; i < value.length; i++) {
      if (i == 0) {
        result += value[i].toUpperCase();
      } else if (value[i] == ' ') {
        result += ' ' + value[i + 1].toUpperCase();
      } else if (value[i - 1] != ' ') {
        result += value[i];
      }
    }
    return result;
  }

  static String getMonthName(int num) {
    switch (num) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'error';
    }
  }

  static String getLocationName(RemoteWeatherState state) {
    if (state.weather!.place != null) {
      if (state.weather!.place!.isNotEmpty) {
        if (state.weather!.place![0]!.locality != null) {
          return state.weather!.place![0]!.locality!;
        }
        if (state.weather!.place![0]!.subLocality != null) {
          return state.weather!.place![0]!.subLocality!;
        }
        if (state.weather!.place![0]!.subAdministrativeArea != null) {
          return state.weather!.place![0]!.subAdministrativeArea!;
        }
        if (state.weather!.place![0]!.administrativeArea != null) {
          return state.weather!.place![0]!.administrativeArea!;
        }
      }
    }
    return '${state.weather!.lat}, ${state.weather!.lon}';
  }

  static Column getCurrentPlaceInfo(RemoteWeatherState state) {
    String? street;
    String? isoCountryCode;
    String? country;
    String? postalCode;
    String? administrativeArea;
    String? subAdministrativeArea;
    String? locality;
    String? subLocality;
    String? thoroughfare;
    String? subThoroughfare;
    if (state.weather!.place != null) {
      if (state.weather!.place!.isNotEmpty) {
        if (state.weather!.place![0]!.street != null) {
          street = state.weather!.place![0]!.street!;
        }
        if (state.weather!.place![0]!.isoCountryCode != null) {
          isoCountryCode = state.weather!.place![0]!.isoCountryCode!;
        }
        if (state.weather!.place![0]!.country != null) {
          country = state.weather!.place![0]!.country!;
        }
        if (state.weather!.place![0]!.postalCode != null) {
          postalCode = state.weather!.place![0]!.postalCode!;
        }
        if (state.weather!.place![0]!.administrativeArea != null) {
          administrativeArea = state.weather!.place![0]!.administrativeArea!;
        }
        if (state.weather!.place![0]!.subAdministrativeArea != null) {
          subAdministrativeArea =
              state.weather!.place![0]!.subAdministrativeArea!;
        }
        if (state.weather!.place![0]!.subLocality != null) {
          locality = state.weather!.place![0]!.locality!;
        }
        if (state.weather!.place![0]!.subLocality != null) {
          subLocality = state.weather!.place![0]!.subLocality!;
        }
        if (state.weather!.place![0]!.thoroughfare != null) {
          thoroughfare = state.weather!.place![0]!.thoroughfare!;
        }
        if (state.weather!.place![0]!.subThoroughfare != null) {
          subThoroughfare = state.weather!.place![0]!.subThoroughfare!;
        }
      }
    }
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lat: ${state.weather!.lat}, Lon: ${state.weather!.lon}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Street: ${street ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'ISO Country Code: ${isoCountryCode ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Country: ${country ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Postal Code: ${postalCode ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Administrative area: ${administrativeArea ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Subadministrative area: ${subAdministrativeArea ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Locality: ${locality ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Sublocality: ${subLocality ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Thoroughfare: ${thoroughfare ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
        const SizedBox(height: 5),
        Text(
          'Subthoroughfare: ${subThoroughfare ?? ''}',
          style: AppTextStyles.whiteInfoBold,
        ),
      ],
    );
  }
}
