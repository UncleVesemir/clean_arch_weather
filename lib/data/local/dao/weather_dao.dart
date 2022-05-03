import 'package:clean_arch_weather/domain/entities/weather.dart';
import 'package:floor/floor.dart';

import '../../../core/utils/constants.dart';

@dao
abstract class WeatherDao {
  @Query('SELECT * FROM $kWeatherTableName')
  Future<List<Weather>> getWeather();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeather(Weather weather);

  @delete
  Future<void> deleteWeather(Weather weather);
}
