import 'package:clean_arch_weather/data/local/data_converters.dart';
import 'package:floor/floor.dart';

import '../../domain/entities/weather.dart';
import 'dao/weather_dao.dart';

@TypeConverters([WeatherTypeConverter])
@Database(version: 1, entities: [Weather])
abstract class AppDatabase extends FloorDatabase {
  WeatherDao get weatherDao;
}
