part of 'daily.dart';

DailyModel _$DailyModelFromJson(Map<String, dynamic> json) => DailyModel(
      dt: json['dt'] as int,
      temp: TemperatureModel.fromJson(json['temp'] as Map<String, dynamic>),
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDeg: json['wind_deg'] as int,
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherElementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyModelToJson(DailyModel instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDeg,
      'weather': instance.weather,
    };
