import 'dart:developer';

import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:clean_arch_weather/presentation/enums/params.dart';
import 'package:clean_arch_weather/styles_const.dart';
import 'package:clean_arch_weather/core/utils/constants.dart';
import 'package:clean_arch_weather/data/gps/gps_location.dart';
import 'package:clean_arch_weather/data/network/api_service.dart';
import 'package:clean_arch_weather/presentation/widgets/overrides.dart';
import 'package:clean_arch_weather/presentation/widgets/city_item.dart';
import 'package:clean_arch_weather/presentation/widgets/main_weather_item.dart';
import 'package:clean_arch_weather/presentation/widgets/weather_item.dart';
import 'package:clean_arch_weather/utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  double _graphMaxX = 0;
  double _graphMaxY = 0;
  double _graphMinX = 0;
  double _graphMinY = 0;

  bool _dataLoading = false;

  Params _selectedParam = Params.temperature;

  int _selectedItem = 0;
  final int _today = DateTime.now().day;

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

  Container _paramTopItem(String name, int index) {
    return Container(
      width: 100,
      height: 30,
      decoration: index == _currentTopParamIndex
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColors.mainLow,
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

  Container _paramBottomItem(String name, int index) {
    return Container(
      width: 100,
      height: 30,
      decoration: index == _currentBottomParamIndex
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColors.mainLow,
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

  List<FlSpot> _initData(RemoteWeatherState state) {
    _dataLoading = true;

    switch (_selectedParam) {
      case Params.temperature:
        {
          return _initTemp(state);
        }
      case Params.windSpeed:
        {
          return _initWindSpeed(state);
        }
      case Params.windDeg:
        {
          return _initWindDeg(state);
        }
      case Params.humidity:
        {
          return _initHumidity(state);
        }
    }
  }

  List<FlSpot> _initTemp(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.hourly[0].dt.toDouble();
    _graphMaxX = state.weather!.hourly.last.dt.toDouble();
    _graphMinY = state.weather!.hourly[0].temp;
    _graphMaxY = 0;
    for (var item in state.weather!.hourly) {
      if (item.temp > _graphMaxY) _graphMaxY = item.temp;
      if (item.temp < _graphMinY) _graphMinY = item.temp;

      _data.add(FlSpot(item.dt.toDouble(), item.temp));
    }

    _dataLoading = false;

    return _data;
  }

  List<FlSpot> _initWindSpeed(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.hourly[0].dt.toDouble();
    _graphMaxX = state.weather!.hourly.last.dt.toDouble();
    _graphMinY = state.weather!.hourly[0].windSpeed;
    _graphMaxY = 0;
    for (var item in state.weather!.hourly) {
      if (item.windSpeed > _graphMaxY) _graphMaxY = item.windSpeed;
      if (item.windSpeed < _graphMinY) _graphMinY = item.windSpeed;

      _data.add(FlSpot(item.dt.toDouble(), item.windSpeed));
    }

    _dataLoading = false;

    return _data;
  }

  List<FlSpot> _initWindDeg(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.hourly[0].dt.toDouble();
    _graphMaxX = state.weather!.hourly.last.dt.toDouble();
    _graphMinY = state.weather!.hourly[0].windDeg.toDouble();
    _graphMaxY = 0;
    for (var item in state.weather!.hourly) {
      if (item.windDeg > _graphMaxY) _graphMaxY = item.windDeg.toDouble();
      if (item.windDeg < _graphMinY) _graphMinY = item.windDeg.toDouble();

      _data.add(FlSpot(item.dt.toDouble(), item.windDeg.toDouble()));
    }

    _dataLoading = false;

    return _data;
  }

  List<FlSpot> _initHumidity(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.hourly[0].dt.toDouble();
    _graphMaxX = state.weather!.hourly.last.dt.toDouble();
    _graphMinY = state.weather!.hourly[0].humidity.toDouble();
    _graphMaxY = 0;
    for (var item in state.weather!.hourly) {
      if (item.humidity > _graphMaxY) _graphMaxY = item.humidity.toDouble();
      if (item.humidity < _graphMinY) _graphMinY = item.humidity.toDouble();

      _data.add(FlSpot(item.dt.toDouble(), item.humidity.toDouble()));
    }

    _dataLoading = false;

    return _data;
  }

  LineChartData _data(RemoteWeatherState state) {
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
            color: Colors.white.withOpacity(0.1),
            dashArray: [9, 0, 9],
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
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
      minX: _graphMinX,
      maxX: _graphMaxX,
      minY: _graphMinY,
      maxY: _graphMaxY,
      lineBarsData: [
        LineChartBarData(
          spots: _initData(state),
          isCurved: true,
          shadow: Shadow(
            color: gradientColors[1].withOpacity(1),
            blurRadius: 25,
            offset: Offset.fromDirection(1.5708, 20),
          ),
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
          // lineChartStepData: LineChartStepData(
          //   stepDirection: 20,
          // ),
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }

  void _onBottomItemChanged(int value) {
    setState(() {
      _currentBottomParamIndex = value;
    });
  }

  void _onTopItemChanged(int value) {
    setState(() {
      _currentTopParamIndex = value;
      value == 0
          ? _selectedParam = Params.temperature
          : value == 1
              ? _selectedParam = Params.windSpeed
              : value == 2
                  ? _selectedParam = Params.windDeg
                  : value == 3
                      ? _selectedParam = Params.humidity
                      : Params.windSpeed;
    });
  }

  Container _buildLine() {
    return Container(
      width: 120,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
    );
  }

  Column _buildBottomSheetPageOpened(RemoteWeatherState state) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildLine(),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 150,
            onSelectedItemChanged: _onTopItemChanged,
            children: [
              _paramTopItem('Temperature', 0),
              _paramTopItem('Wind Speed', 1),
              _paramTopItem('Wind Deg', 2),
              _paramTopItem('Humidity', 3),
            ],
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 200.0,
          child: _dataLoading
              ? SpinKitWave(color: AppColors.mainLow)
              : LineChart(_data(state)),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 100.0,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 150,
            onSelectedItemChanged: _onBottomItemChanged,
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
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
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
                  city: 'Polatsk',
                  windSpeed: 23,
                  temperature: 23,
                  humidity: 78),
              const SizedBox(height: 15),
              const CityItem(
                  city: 'Novopolatsk',
                  windSpeed: 18,
                  temperature: 26,
                  humidity: 83),
              const SizedBox(height: 15),
              const CityItem(
                  city: 'Minsk', windSpeed: 10, temperature: 30, humidity: 88),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }

  List<WeatherItem> _initClosedSheet(RemoteWeatherState state) {
    List<WeatherItem> _items = [];
    for (var i = 0; i < 8; i++) {
      var time = DateTime.fromMillisecondsSinceEpoch(
          1000 * state.weather!.hourly[i].dt);
      var minutes = DateTime.fromMillisecondsSinceEpoch(
              1000 * state.weather!.hourly[i].dt)
          .minute;
      var minutesToStr = '';
      if (minutes < 10) {
        minutesToStr = '0$minutes';
      } else {
        minutesToStr = minutes.toString();
      }
      _items.add(WeatherItem(
        image: state.weather!.hourly[i].weather[0].image,
        temp: state.weather!.hourly[i].temp,
        time:
            '${DateTime.fromMillisecondsSinceEpoch(1000 * state.weather!.hourly[i].dt).hour}:$minutesToStr',
      ));
      i++;
    }
    return _items;
  }

  ListView _weatherBuilder(RemoteWeatherState state) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.weather!.hourly.length,
      itemBuilder: (BuildContext ctx, int i) {
        var time = DateTime.fromMillisecondsSinceEpoch(
            1000 * state.weather!.hourly[i].dt);
        var hour = time.hour;
        var minutes = time.minute;
        var minutesToStr = '';
        if (minutes < 10) {
          minutesToStr = '0$minutes';
        } else {
          minutesToStr = minutes.toString();
        }
        return Row(
          children: [
            WeatherItem(
              image: state.weather!.hourly[i].weather[0].image,
              temp: state.weather!.hourly[i].temp,
              time: '$hour:$minutesToStr',
            ),
            const SizedBox(width: 20),
          ],
        );
      },
    );
  }

  Padding _buildBottomSheetPageClosed(RemoteWeatherState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: state is RemoteWeatherLoading
          ? Column(
              children: [
                const SizedBox(height: 70),
                SpinKitWave(
                  color: AppColors.lowDarkColor,
                ),
              ],
            )
          : state is RemoteWeatherDone
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildLine(),
                    const SizedBox(height: 20),
                    Opacity(
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
                          SizedBox(
                            height: 110,
                            child: _weatherBuilder(state),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Text(state.error!.message),
    );
  }

  NotificationListener<DraggableScrollableNotification> _buildSheet(
      RemoteWeatherState state) {
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
        maxChildSize: 0.88,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.mainMid,
              // gradient: LinearGradient(
              //   colors: AppGradientColors.gradientSheet,
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: ScrollConfiguration(
              behavior: DisableGlowingEffect(),
              child: MediaQuery.removePadding(
                context: context,
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  children: _percent > -0.15
                      ? [_buildBottomSheetPageClosed(state)]
                      : [_buildBottomSheetPageOpened(state)],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void getLocation() async {
    var data = await GetLocation.getPermission();
    print(data ?? 'null');
  }

  List<MainItem> _initMainList(RemoteWeatherState state) {
    List<MainItem> _items = [];
    for (var i = 0; i < state.weather!.daily.length; i++) {
      _items.add(
        MainItem(
          image: state.weather!.daily[i].weather[0].image,
          description:
              state.weather!.daily[i].weather[0].description.toString(),
          humidity: state.weather!.daily[i].humidity,
          temp: state.weather!.daily[i].temp.day,
          windSpeed: state.weather!.daily[i].windSpeed,
        ),
      );
    }
    return _items;
  }

  void _onMainItemChange(int item) => setState(
        () => _selectedItem = item,
      );

  Text _buildDate(RemoteWeatherState state) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        1000 * state.weather!.daily[_selectedItem].dt);
    var day = DateTime.fromMillisecondsSinceEpoch(
            1000 * state.weather!.daily[_selectedItem].dt)
        .day;
    var month = Utils.getMonthName(DateTime.fromMillisecondsSinceEpoch(
            1000 * state.weather!.daily[_selectedItem].dt)
        .month);
    bool isToday = false;
    bool isTomorrow = false;
    if (_today == day) isToday = true;
    if (day - _today == 1) isTomorrow = true;
    return Text(
      isToday
          ? 'Today, $day $month'
          : isTomorrow
              ? 'Tomorrow $day $month'
              : '${Utils.getWeekdayName(date.weekday)}, $day $month',
      style: AppTextStyles.lowDarkS24W400Normal,
    );
  }

  Widget _buildBody(RemoteWeatherState state) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          state is RemoteWeatherLoading
              ? Container(
                  color: AppColors.mainLow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 200),
                      SpinKitWave(
                        color: AppColors.darkColor,
                        itemCount: 6,
                      ),
                    ],
                  ),
                )
              : state is RemoteWeatherDone
                  ? Container(
                      color: AppColors.mainLow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDate(state),
                                const SizedBox(height: 3),
                                Text('Polotsk', style: AppTextStyles.cityName),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 360,
                            width: double.infinity,
                            child: ListWheelScrollViewX(
                              itemExtent: 370,
                              diameterRatio: 5,
                              scrollDirection: Axis.horizontal,
                              children: _initMainList(state),
                              onSelectedItemChanged: _onMainItemChange,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(state.error!.message),
          _buildSheet(state),
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.mainLow,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // getLocation();
    return BlocBuilder<RemoteWeatherBloc, RemoteWeatherState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }
}
