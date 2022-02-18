import 'package:clean_arch_weather/styles_const.dart';
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String image;
  final String time;
  final double temp;
  const WeatherItem({
    required this.image,
    required this.temp,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(22)),
        color: Colors.grey.withOpacity(0.1),
      ),
      height: 105,
      width: 65,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 35, height: 35, child: Image.asset(image)),
              const SizedBox(height: 7),
              Text(
                time,
                style: AppTextStyles.extraLowText,
              ),
              const SizedBox(height: 3),
              Text(
                '${temp.toInt()}°C',
                style: AppTextStyles.mediumText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
