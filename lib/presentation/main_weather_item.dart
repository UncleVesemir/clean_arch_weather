import 'dart:ui';

import 'package:clean_arch_weather/const.dart';
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
            style: AppTextStyles.bigTextDarkColor,
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
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 100,
                    offset: const Offset(0, 40), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                Images.sun + '27.png',
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text('Sunny', style: AppTextStyles.bigTextlowDarkColor),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _rowItem('Wind', '234'),
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
