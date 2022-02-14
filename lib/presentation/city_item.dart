import 'package:clean_arch_weather/const.dart';
import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  final String city;
  final double windSpeed;
  final double temperature;
  final double humidity;
  const CityItem({
    required this.city,
    required this.windSpeed,
    required this.temperature,
    required this.humidity,
    Key? key,
  }) : super(key: key);

  Column _rowItem(String top, String bottom) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          top,
          style: AppTextStyles.whiteS7w600Normal,
        ),
        Text(
          bottom,
          style: AppTextStyles.lowText,
        ),
      ],
    );
  }

  Container _verticalDivider() {
    return Container(
      height: 15,
      width: 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.lowDarkColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Row(
          children: [
            Flexible(
              flex: 8,
              child: Container(
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 25, bottom: 10, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Location',
                        style: AppTextStyles.extraLowText,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        city,
                        style: AppTextStyles.bigText,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _rowItem('Wind', '${windSpeed.toInt()} m/s'),
                          _verticalDivider(),
                          _rowItem('Temp', '${temperature.toInt()}°C'),
                          _verticalDivider(),
                          _rowItem('Humid.', '${humidity.toInt()}%'),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
        Image.asset(
          Images.cloud + '33.png',
          width: 90,
          height: 90,
        ),
      ],
    );
  }
}
