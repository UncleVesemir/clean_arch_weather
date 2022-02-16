import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/material.dart';

class AppColors {
  // static HexColor mainColor = HexColor('#4F29E4');
  // static HexColor mainColor = HexColor('#000000');
  static HexColor mainColor = HexColor('#39486E');
  static HexColor lowMainColor = HexColor('#5635EA');
  static HexColor lowTextColor = HexColor('#845AF9');
  static HexColor darkColor = HexColor('#39486E');
  static HexColor lowDarkColor = HexColor('#E8ECF4');
}

class AppGradientColors {
  static final List<Color> gradientText = [
    AppColors.darkColor.withOpacity(0.4),
    AppColors.darkColor,
  ];

  static final List<Color> test = [
    HexColor('#000000'),
    HexColor('#ffffff'),
  ];
}

class AppTextStyles {
  static const TextStyle extraLowText = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle lightLowText = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle lowText = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  static final TextStyle lowTextInactive = TextStyle(
    color: AppColors.lowTextColor,
    fontSize: 14,
  );

  static final TextStyle lowTextDarkColor = TextStyle(
    color: AppColors.darkColor,
    fontSize: 12,
  );

  static const TextStyle mediumText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle darkS20W400Normal = TextStyle(
    color: AppColors.darkColor,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bigText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle cityName = TextStyle(
    color: AppColors.darkColor,
    fontSize: 30,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle bigTextlowDarkColor = TextStyle(
    color: AppColors.lowDarkColor,
    fontSize: 42,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle lowDarkS24W400Normal = TextStyle(
    color: AppColors.darkColor.withOpacity(0.6),
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle whiteS7w600Normal = TextStyle(
    color: AppColors.lowDarkColor,
    fontSize: 7,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle mediumTextlowDarkColor = TextStyle(
    color: AppColors.lowDarkColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bigTextDarkColor = TextStyle(
    color: AppColors.darkColor,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
}

class Images {
  static const String cloud = 'assets/images/cloud/';
  static const String lighting = 'assets/images/lighting/';
  static const String moon = 'assets/images/moon/';
  static const String rain = 'assets/images/rain/';
  static const String snow = 'assets/images/snow/';
  static const String star = 'assets/images/star/';
  static const String sun = 'assets/images/sun/';
}
