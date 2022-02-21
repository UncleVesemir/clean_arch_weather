import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';

class Utils {
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
    final month = Utils.getMonthName(date.month);
    final weekDay = Utils.getWeekdayName(date.weekday);
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
    final month = Utils.getMonthName(date.month);
    final weekDay = Utils.getWeekdayName(date.weekday);
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
    final month = Utils.getMonthName(date.month);
    final weekDay = Utils.getWeekdayName(date.weekday);
    var windDeg = '';
    if (y > 22.5 && y <= 67.5) windDeg = 'North-East';
    if (y > 67.5 && y <= 112.5) windDeg = 'North-East';
    if (y > 112.5 && y <= 157.5) windDeg = 'East';
    if (y > 202.5 && y <= 247.5) windDeg = 'South-East';
    if (y > 157.5 && y <= 202.5) windDeg = 'South';
    if (y > 247.5 && y <= 292.5) windDeg = 'South-West';
    if (y > 292.5 && y <= 337.5) windDeg = 'West';
    if (y > 337.5 || y <= 22.5) windDeg = 'North-West';
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
    final month = Utils.getMonthName(date.month);
    final weekDay = Utils.getWeekdayName(date.weekday);
    return '$month ${date.day}, $weekDay, ${date.hour}:$minutesToStr, $y%';
  }

  static String getDateTimePeriodHourly(RemoteWeatherState state) {
    final fD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.hourly.first.dt.toInt() * 1000);
    final sD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.hourly.last.dt.toInt() * 1000);
    return '${Utils.getMonthName(fD.month)} ${fD.day} - ${Utils.getMonthName(sD.month)} ${sD.day}';
  }

  static String getDateTimePeriodDaily(RemoteWeatherState state) {
    final fD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.daily.first.dt.toInt() * 1000);
    final sD = DateTime.fromMillisecondsSinceEpoch(
        state.weather!.daily.last.dt.toInt() * 1000);
    return '${Utils.getMonthName(fD.month)} ${fD.day} - ${Utils.getMonthName(sD.month)} ${sD.day}';
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
}
