import 'dart:developer';

import 'package:clean_arch_weather/const.dart';
import 'package:clean_arch_weather/data/gps/gps_location.dart';
import 'package:clean_arch_weather/data/network/api_service.dart';
import 'package:clean_arch_weather/overrides.dart';
import 'package:clean_arch_weather/presentation/city_item.dart';
import 'package:clean_arch_weather/presentation/main_weather_item.dart';
import 'package:clean_arch_weather/presentation/weather_item.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_glow/flutter_glow.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  int _currentTopParamIndex = 0;
  int _currentBottomParamIndex = 0;
  double _percent = 0.0;

  final List<BottomNavyBarItem> _bottomBarItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.maps_home_work_rounded),
      title: const Text('Home'),
      activeColor: AppColors.mainColor,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.search),
      title: const Text('Search'),
      activeColor: AppColors.mainColor,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.settings_sharp),
      title: const Text('Settings'),
      activeColor: AppColors.mainColor,
      textAlign: TextAlign.center,
    ),
  ];

  Container _paramBottomItem(String name, int index) {
    return Container(
      width: 100,
      height: 30,
      decoration: index == _currentBottomParamIndex
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColors.lowMainColor,
            )
          : null,
      child: Center(
        child: Text(
          name,
          style: index == _currentBottomParamIndex
              ? AppTextStyles.mediumText
              : AppTextStyles.lowTextInactive,
        ),
      ),
    );
  }

  Container _paramTopItem(String name, int index) {
    return Container(
      width: 100,
      height: 30,
      decoration: index == _currentTopParamIndex
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColors.lowMainColor,
            )
          : null,
      child: Center(
        child: Text(
          name,
          style: index == _currentTopParamIndex
              ? AppTextStyles.mediumText
              : AppTextStyles.lowTextInactive,
        ),
      ),
    );
  }

  Padding _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 18.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 7.0, right: 7.0, top: 7.0, bottom: 7),
          child: BottomNavyBar(
            showElevation: false,
            selectedIndex: _currentPageIndex,
            itemCornerRadius: 15,
            containerHeight: 70,
            curve: Curves.easeIn,
            items: _bottomBarItems,
            onItemSelected: (index) =>
                setState(() => _currentPageIndex = index),
          ),
        ),
      ),
    );
  }

  List<Color> gradientColors = [
    AppColors.lowDarkColor.withOpacity(0.1),
    Colors.white,
    AppColors.lowDarkColor.withOpacity(0.1),
  ];

  List<Color> gradientColors2 = [
    AppColors.lowMainColor.withOpacity(0.1),
    AppColors.lowMainColor,
    AppColors.lowMainColor.withOpacity(0.1),
  ];

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        getTouchedSpotIndicator: (LineChartBarData data, List<int> list) {
          List<TouchedSpotIndicatorData> spots = [
            TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white,
                dashArray: [9, 0, 9],
              ),
              FlDotData(
                show: true,
                getDotPainter: (FlSpot spot, double value,
                    LineChartBarData data, int value2) {
                  return FlDotCirclePainter(
                    color: Colors.white,
                    radius: 10,
                    // strokeWidth: 2,
                    // strokeColor: Colors.black,
                  );
                },
              ),
            ),
          ];
          return spots;
        },
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          if (event is FlLongPressStart) {}
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (line) {
            final List<LineTooltipItem> items = [];
            for (var element in line) {
              final text =
                  '${element.x.toInt()} January, 14:00, ${element.y}°C';
              items.add(
                LineTooltipItem(
                  text,
                  AppTextStyles.lightLowText,
                ),
              );
            }
            return items;
          },
          tooltipBgColor: Colors.grey.withOpacity(0.1),
          tooltipRoundedRadius: 30.0,
          tooltipMargin: 20,
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        // verticalInterval: 2,
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.white.withOpacity(0.1),
            dashArray: [9, 0, 9],
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.white.withOpacity(0.1),
            dashArray: [9, 0, 9],
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2, 1),
            FlSpot(3, 5),
            FlSpot(4, 2),
            FlSpot(5, 8),
            FlSpot(6, 3),
            FlSpot(7, 1),
            FlSpot(8, 5),
            FlSpot(9, 2),
            FlSpot(10, 8),
          ],
          isCurved: true,
          // shadow: Shadow(
          //   color: gradientColors[1].withOpacity(0.6),
          //   blurRadius: 20,
          //   offset: Offset.fromDirection(1.5708, 20),
          // ),
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0)!,
            ColorTween(begin: gradientColors[1], end: gradientColors[1])
                .lerp(1)!,
            ColorTween(begin: gradientColors[1], end: gradientColors[2])
                .lerp(1)!,
          ],
          barWidth: 8,
          isStrokeCapRound: true,
          lineChartStepData: LineChartStepData(
            stepDirection: 20,
          ),
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }

  Column _buildBottomSheetPageOpened() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 150,
            onSelectedItemChanged: (value) {
              setState(() {
                _currentTopParamIndex = value;
              });
            },
            children: [
              _paramTopItem('Temperature', 0),
              _paramTopItem('Wind', 1),
              _paramTopItem('Humidity', 2),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: LineChart(avgData()),
        ),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 150,
            onSelectedItemChanged: (value) {
              setState(() {
                _currentBottomParamIndex = value;
              });
            },
            children: [
              _paramBottomItem('Monday', 0),
              _paramBottomItem('Tuesday', 1),
              _paramBottomItem('Wednesday', 2),
              _paramBottomItem('Thursday', 3),
              _paramBottomItem('Friday', 4),
              _paramBottomItem('Saturday', 5),
              _paramBottomItem('Sunday', 6),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Other City',
              style: AppTextStyles.bigText,
            ),
            Text(
              'View All',
              style: AppTextStyles.mediumText,
            ),
          ],
        ),
        const SizedBox(height: 20),
        const CityItem(
            city: 'Polatsk', windSpeed: 23, temperature: 23, humidity: 78),
        const SizedBox(height: 15),
        const CityItem(
            city: 'Novopolatsk', windSpeed: 18, temperature: 26, humidity: 83),
        const SizedBox(height: 15),
        const CityItem(
            city: 'Minsk', windSpeed: 10, temperature: 30, humidity: 88),
      ],
    );
  }

  Opacity _buildBottomSheetPageClosed() {
    return Opacity(
      opacity: 1 - _percent.abs() * 6,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today',
                style: AppTextStyles.lowText,
              ),
              Row(
                children: const [
                  Text(
                    'Next 7 Days',
                    style: AppTextStyles.lowText,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              WeatherItem(),
              WeatherItem(),
              WeatherItem(),
              WeatherItem(),
            ],
          ),
        ],
      ),
    );
  }

  NotificationListener<DraggableScrollableNotification> _buildSheet() {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          _percent = -2 * notification.extent + 0.8;
        });
        return true;
      },
      child: DraggableScrollableSheet(
        minChildSize: 0.4,
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 40, bottom: 15),
              child: ScrollConfiguration(
                behavior: DisableGlowingEffect(),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  children: _percent > -0.15
                      ? [_buildBottomSheetPageClosed()]
                      : [_buildBottomSheetPageOpened()],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Widget> _mainItems = const [
    MainItem(),
    MainItem(),
    MainItem(),
    MainItem(),
    MainItem(),
  ];

  void getLocation() async {
    var data = await GetLocation.getPermission();
    print(data ?? 'null');
  }

  void getWeather() async {
    ApiService apiService = ApiService(dio.Dio());

    final response = await apiService.getWeather(
      32,
      53,
      '7aeb287065deb65dcdd0b7a08e8d6267',
      'en',
      'metric',
    );

    print(response.daily[0].toJson());
  }

  @override
  Widget build(BuildContext context) {
    // getLocation();
    // printWeather();
    getWeather();
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today, 11 Feb',
                            style: AppTextStyles.lowDarkS24W400Normal),
                        const SizedBox(height: 3),
                        Text('Polotsk', style: AppTextStyles.cityName),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 370,
                    width: double.infinity,
                    child: ListWheelScrollViewX(
                      itemExtent: 340,
                      diameterRatio: 3,
                      scrollDirection: Axis.horizontal,
                      children: _mainItems,
                    ),
                  ),
                ],
              ),
            ),
            _buildSheet(),
            Positioned(
              left: 0,
              right: 0,
              bottom: -5 * (1 - _percent * 80),
              child: Opacity(
                opacity: 1 + _percent,
                child: _buildBottomBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
