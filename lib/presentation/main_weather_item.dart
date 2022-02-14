import 'package:clean_arch_weather/const.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget {
  const MainItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Column _rowItem(String top, String bottom) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            top,
            style: AppTextStyles.lowTextDarkColor,
          ),
          Text(
            bottom,
            style: AppTextStyles.darkS20W400Normal,
          ),
        ],
      );
    }

    Container _verticalDivider() {
      return Container(
        height: 30,
        width: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.lowDarkColor,
        ),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: Image.asset(
              Images.sun + '27.png',
            ),
          ),
          const SizedBox(height: 5),
          GradientText(
            'Cloudy',
            gradientDirection: GradientDirection.btt,
            colors: AppGradientColors.gradientText,
            style: AppTextStyles.bigTextDarkColor,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _rowItem('Wind', '4 m/s'),
              _verticalDivider(),
              _rowItem('Temp', '30°C'),
              _verticalDivider(),
              _rowItem('Humid.', '25%'),
            ],
          ),
        ],
      ),
    );
  }
}
