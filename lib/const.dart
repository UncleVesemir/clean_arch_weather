import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/material.dart';

class AppColors {
  static HexColor mainColor = HexColor('#4F29E4');
  static HexColor lowMainColor = HexColor('#5635EA');
  static HexColor lowTextColor = HexColor('#845AF9');
  static HexColor darkColor = HexColor('#39486E');
  static HexColor lowDarkColor = HexColor('#E8ECF4');
}

class AppTextStyles {
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

  static const TextStyle bigText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bigTextlowDarkColor = TextStyle(
    color: AppColors.lowDarkColor,
    fontSize: 42,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle mediumTextlowDarkColor = TextStyle(
    color: AppColors.lowDarkColor,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bigTextDarkColor = TextStyle(
    color: AppColors.darkColor,
    fontSize: 32,
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
