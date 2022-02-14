import 'package:clean_arch_weather/const.dart';
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(22)),
        color: AppColors.lowMainColor,
      ),
      height: 105,
      width: 62,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.sun + '27.png'),
              const SizedBox(height: 7),
              const Text(
                '12:00',
                style: AppTextStyles.extraLowText,
              ),
              const SizedBox(height: 3),
              const Text(
                '35°C',
                style: AppTextStyles.mediumText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
