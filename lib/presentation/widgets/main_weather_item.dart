import 'package:clean_arch_weather/styles_const.dart';
import 'package:clean_arch_weather/utils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget {
  final String image;
  final String description;
  final double windSpeed;
  final double temp;
  final int humidity;
  const MainItem({
    required this.image,
    required this.description,
    required this.humidity,
    required this.temp,
    required this.windSpeed,
    Key? key,
  }) : super(key: key);

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
          const SizedBox(height: 3),
          Text(
            bottom,
            style: AppTextStyles.darkS24W400Normal,
          ),
        ],
      );
    }

    Container _verticalDivider() {
      return Container(
        height: 40,
        width: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainDark,
          // gradient: LinearGradient(
          //   colors: AppGradientColors.gradientDivider,
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
      );
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      // color: Colors.transparent,
      child: Container(
        // width: 120,
        height: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: Image.asset(image),
              ),
              const SizedBox(height: 15),
              // GradientText(
              //   description,
              //   gradientDirection: GradientDirection.btt,
              //   colors: AppGradientColors.gradientText,
              //   style: AppTextStyles.bigTextDarkColor,
              // ),
              Text(
                Utils.toUpperCase(description),
                style: AppTextStyles.descriptionBold,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  _rowItem('Wind', '${windSpeed.toInt()} m/s'),
                  _verticalDivider(),
                  _rowItem('Temp', '${temp.toInt()}°C'),
                  _verticalDivider(),
                  _rowItem('Humid.', '${humidity.toInt()}%'),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
