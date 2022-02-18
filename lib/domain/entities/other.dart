// MUST BE IMPLEMENTED LATER

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

class EnumValuesReverse<T> {
  Map<Enum, T> map;
  Map<T, Enum>? reverseMap;

  EnumValuesReverse(this.map);

  Map<T, Enum> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
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
