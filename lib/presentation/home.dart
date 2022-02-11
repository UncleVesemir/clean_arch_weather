import 'package:clean_arch_weather/const.dart';
import 'package:clean_arch_weather/overrides.dart';
import 'package:clean_arch_weather/presentation/main_weather_item.dart';
import 'package:clean_arch_weather/presentation/weather_item.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
        const SizedBox(height: 240),
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
      ],
    );
  }

  Column _buildBottomSheetPageClosed() {
    return Column(
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
        const SizedBox(height: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today, 11 Feb',
                        style: AppTextStyles.mediumTextlowDarkColor),
                    const SizedBox(height: 3),
                    Text('Polotsk', style: AppTextStyles.bigTextDarkColor),
                    const Padding(
                      padding: EdgeInsets.all(25),
                      child: MainItem(),
                    ),
                  ],
                ),
              ),
            ),
            _buildSheet(),
            Positioned(
              left: 0,
              right: 0,
              bottom: -5 * (1 - _percent * 19),
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
