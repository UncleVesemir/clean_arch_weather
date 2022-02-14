import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Minutely>? minutely;
  List<Current>? hourly;
  List<Daily>? daily;
  List<Alert>? alerts;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        minutely: json["minutely"] == null
            ? null
            : List<Minutely>.from(
                json["minutely"].map((x) => Minutely.fromJson(x))),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
        alerts: json["alerts"] == null
            ? null
            : List<Alert>.from(json["alerts"].map((x) => Alert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "minutely": minutely != null
            ? List<dynamic>.from(minutely!.map((x) => x.toJson()))
            : null,
        "hourly": hourly != null
            ? List<dynamic>.from(hourly!.map((x) => x.toJson()))
            : null,
        "daily": daily != null
            ? List<dynamic>.from(daily!.map((x) => x.toJson()))
            : null,
        "alerts": alerts != null
            ? List<dynamic>.from(alerts!.map((x) => x.toJson()))
            : null,
      };
}

class Alert {
  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  String senderName;
  String event;
  int start;
  int end;
  String description;
  List<String> tags;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json["sender_name"],
        event: json["event"],
        start: json["start"],
        end: json["end"],
        description: json["description"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sender_name": senderName,
        "event": event,
        "start": start,
        "end": end,
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  int dt;
  int? sunrise;
  int? sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double? windGust;
  List<WeatherElement> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust:
            json["wind_gust"] == null ? null : json["wind_gust"].toDouble(),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class WeatherElement {
  WeatherElement({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  Main main;
  Description description;
  Icon icon;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: mainValues.map[json["main"]]!,
        description: descriptionValues.map[json["description"]]!,
        icon: iconValues.map[json["icon"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": iconValues.reverse[icon],
      };
}

enum Description {
//THUNDERSTORM
  THUNDERSTORM_WITH_LIGHT_RAIN,
  THUNDERSTORM_WITH_RAIN,
  THUNDERSTORM_WITH_HEAVY_RAIN,
  LIGHT_THUNDERSTORM,
  THUNDERSTORM,
  HEAVY_THUNDERSTORM,
  RAGGED_THUNDERSTORM,
  THUNDERSTORM_WITH_LIGHT_DRIZZLE,
  THUNDERSTORM_WITH_DRIZZLE,
  THUNDERSTORM_WITH_HEAVY_DRIZZLE,
//DRIZZLE
  LIGHT_INTENSITY_DRIZZLE,
  DRIZZLE,
  HEAVY_INTENSITY_DRIZZLE,
  LIGHT_INTENSITY_DRIZZLE_RAIN,
  DRIZZLE_RAIN,
  HEAVY_INTENSITY_DRIZZLE_RAIN,
  SHOWER_RAIN_AND_DRIZZLE,
  HEAVY_SHOWER_RAIN_AND_DRIZZLE,
  SHOWER_DRIZZLE,
//RAIN
  LIGHT_RAIN,
  MODERATE_RAIN,
  HEAVY_INTENSITY_RAIN,
  VERY_HEAVY_RAIN,
  EXTREME_RAIN,
  FREEZING_RAIN,
  LIGHT_INTENSITY_SHOWER_RAIN,
  SHOWER_RAIN,
  HEAVY_INTENSITY_SHOWER_RAIN,
  RAGGED_SHOWER_RAIN,
//SNOW
  LIGHT_SNOW,
  SNOW,
  HEAVY_SNOW,
  SLEET,
  LIGHT_SHOWER_SLEET,
  SHOWER_SLEET,
  LIGHT_RAIN_AND_SNOW,
  RAIND_AND_SNOW,
  LIGHT_SHOWER_SNOW,
  SHOWER_SNOW,
  HEAVY_SHOWER_SNOW,
//ATMOSPHERE
  MIST,
  SMOKE,
  HAZE,
  SAND_DUST_WHIRLS,
  FOG,
  SAND,
  DUST,
  VOLCANIC_ASH,
  SQUALLS,
  TORNADO,
//CLEAR
  CLEAR_SKY,
//CLOUDS
  FEW_CLOUDS,
  SCATTERED_CLOUDS,
  BROKEN_CLOUDS,
  OVERCAST_CLOUDS,
}

final descriptionValues = EnumValues({
  "thunderstorm with light rain": Description.THUNDERSTORM_WITH_LIGHT_RAIN,
  "thunderstorm with rain": Description.THUNDERSTORM_WITH_RAIN,
  "thunderstorm with heavy rain": Description.THUNDERSTORM_WITH_HEAVY_RAIN,
  "light thunderstorm": Description.LIGHT_THUNDERSTORM,
  "thunderstorm": Description.THUNDERSTORM,
  "heavy thunderstorm": Description.HEAVY_THUNDERSTORM,
  "ragged thunderstorm": Description.RAGGED_THUNDERSTORM,
  "thunderstorm with light drizzle":
      Description.THUNDERSTORM_WITH_LIGHT_DRIZZLE,
  "thunderstorm with drizzle": Description.THUNDERSTORM_WITH_DRIZZLE,
  "thunderstorm with heavy drizzle":
      Description.THUNDERSTORM_WITH_HEAVY_DRIZZLE,
  //
  "light intensity drizzle": Description.LIGHT_INTENSITY_DRIZZLE,
  "drizzle": Description.DRIZZLE,
  "heavy intensity drizzle": Description.HEAVY_INTENSITY_DRIZZLE,
  "light intensity drizzle rain": Description.LIGHT_INTENSITY_DRIZZLE_RAIN,
  "drizzle rain": Description.DRIZZLE_RAIN,
  "heavy intensity drizzle rain": Description.HEAVY_INTENSITY_DRIZZLE_RAIN,
  "shower rain and drizzle": Description.SHOWER_RAIN_AND_DRIZZLE,
  "heavy shower rain and drizzle": Description.HEAVY_SHOWER_RAIN_AND_DRIZZLE,
  "shower drizzle": Description.SHOWER_DRIZZLE,
  //
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN,
  "heavy intensity rain": Description.HEAVY_INTENSITY_RAIN,
  "very heavy rain": Description.VERY_HEAVY_RAIN,
  "extreme rain": Description.EXTREME_RAIN,
  "freezing rain": Description.FREEZING_RAIN,
  "light intensity shower rain": Description.LIGHT_INTENSITY_SHOWER_RAIN,
  "shower rain": Description.SHOWER_RAIN,
  "heavy intensity shower rain": Description.HEAVY_INTENSITY_SHOWER_RAIN,
  "ragged shower rain": Description.RAGGED_SHOWER_RAIN,
  //
  "light snow": Description.LIGHT_SNOW,
  "Snow": Description.SNOW,
  "Heavy snow": Description.HEAVY_SNOW,
  "Sleet": Description.SLEET,
  "Light shower sleet": Description.LIGHT_SHOWER_SLEET,
  "Shower sleet": Description.SHOWER_SLEET,
  "Light rain and snow": Description.LIGHT_RAIN_AND_SNOW,
  "Rain and snow": Description.RAIND_AND_SNOW,
  "Light shower snow": Description.LIGHT_SHOWER_SNOW,
  "Shower snow": Description.SHOWER_SNOW,
  //
  "mist": Description.MIST,
  "Smoke": Description.SMOKE,
  "Haze": Description.HAZE,
  "sand/ dust whirls": Description.SAND_DUST_WHIRLS,
  "fog": Description.FOG,
  "sand": Description.SAND,
  "dust": Description.DUST,
  "volcanic ash": Description.VOLCANIC_ASH,
  "squalls": Description.SQUALLS,
  "tornado": Description.TORNADO,
  //
  "clear sky": Description.CLEAR_SKY,
  //
  "few clouds": Description.FEW_CLOUDS,
  "broken clouds": Description.BROKEN_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS,
  "overcast clouds": Description.OVERCAST_CLOUDS,
});

enum Icon { THE_13_D, THE_04_D, THE_13_N, THE_04_N }

final iconValues = EnumValues({
  "01d": Icon.THE_04_D,
  "01n": Icon.THE_04_D,
  "02d": Icon.THE_04_D,
  "02n": Icon.THE_04_D,
  "03d": Icon.THE_04_D,
  "03n": Icon.THE_04_D,
  "04d": Icon.THE_04_D,
  "04n": Icon.THE_04_N,
  "09d": Icon.THE_04_D,
  "09n": Icon.THE_04_D,
  "10d": Icon.THE_04_D,
  "10n": Icon.THE_04_D,
  "11d": Icon.THE_04_D,
  "11n": Icon.THE_04_D,
  "13d": Icon.THE_13_D,
  "13n": Icon.THE_13_N,
  "50d": Icon.THE_04_D,
  "50n": Icon.THE_04_D,
});

enum Main {
  THUNDERSTORM,
  DRIZZLE,
  RAIN,
  MIST,
  SMOKE,
  HAZE,
  DUST,
  FOG,
  SAND,
  ASH,
  SQUALL,
  TORNADO,
  CLEAR,
  SNOW,
  CLOUDS,
}

final mainValues = EnumValues({
  "Clouds": Main.CLOUDS,
  "Snow": Main.SNOW,
  "Thunderstorm": Main.THUNDERSTORM,
  "Drizzle": Main.DRIZZLE,
  "Rain": Main.RAIN,
  "Mist": Main.MIST,
  "Smoke": Main.SMOKE,
  "Haze": Main.HAZE,
  "Dust": Main.DUST,
  "Fog": Main.FOG,
  "Sand": Main.SAND,
  "Ash": Main.ASH,
  "Squall": Main.SQUALL,
  "Tornado": Main.TORNADO,
  "Clear": Main.CLEAR,
});

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
  });

  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  double windGust;
  List<WeatherElement> weather;
  int clouds;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"].toDouble(),
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"].toDouble(),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        clouds: json["clouds"],
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double night;
  double eve;
  double morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Minutely {
  Minutely({
    required this.dt,
    required this.precipitation,
  });

  int dt;
  double precipitation;

  factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json["dt"],
        precipitation: json["precipitation"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "precipitation": precipitation,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
