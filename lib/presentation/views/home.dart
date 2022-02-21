import 'dart:developer';

import 'package:clean_arch_weather/domain/entities/current.dart';
import 'package:clean_arch_weather/domain/entities/daily.dart';
import 'package:clean_arch_weather/presentation/blocs/bloc/remote_weather_bloc.dart';
import 'package:clean_arch_weather/presentation/enums/params.dart';
import 'package:clean_arch_weather/presentation/enums/period.dart';
import 'package:clean_arch_weather/presentation/widgets/radar_chart.dart';
import 'package:clean_arch_weather/styles_const.dart';
import 'package:clean_arch_weather/presentation/widgets/overrides.dart';
import 'package:clean_arch_weather/presentation/widgets/city_item.dart';
import 'package:clean_arch_weather/presentation/widgets/main_weather_item.dart';
import 'package:clean_arch_weather/presentation/widgets/weather_item.dart';
import 'package:clean_arch_weather/utils.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';

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

  bool _switcherValue = false;

  bool _dataLoading = false;

  Params _selectedParam = Params.temperature;
  Period _selectedPeriod = Period.twoDays;

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
      height: 30,
      width: 220,
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
            backgroundColor: Colors.white,
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

  void _initChart(RemoteWeatherState state) {
    setState(() {
      _dataLoading = true;

      _graphMaxX = 0;
      _graphMaxY = 0;
      _graphMinX = 0;
      _graphMinY = 0;

      _initData(state);

      _dataLoading = false;
    });
  }

  List<FlSpot> _initData(RemoteWeatherState state) {
    if (_selectedPeriod == Period.twoDays) {
      switch (_selectedParam) {
        case Params.temperature:
          {
            return _initTempHourly(state);
          }
        case Params.windSpeed:
          {
            return _initWindSpeedHourly(state);
          }
        case Params.windDeg:
          {
            return _initWindDegHourly(state);
          }
        case Params.humidity:
          {
            return _initHumidityHourly(state);
          }
      }
    } else {
      switch (_selectedParam) {
        case Params.temperature:
          {
            return _initTempDaily(state);
          }
        case Params.windSpeed:
          {
            return _initWindSpeedDaily(state);
          }
        case Params.windDeg:
          {
            return _initWindDegDaily(state);
          }
        case Params.humidity:
          {
            return _initHumidityDaily(state);
          }
      }
    }
  }

  List<FlSpot> _initTempHourly(RemoteWeatherState state) {
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

    return _data;
  }

  List<FlSpot> _initTempDaily(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.daily[0].dt.toDouble();
    _graphMaxX = state.weather!.daily.last.dt.toDouble();
    _graphMinY = state.weather!.daily[0].temp.day;
    _graphMaxY = 0;
    for (var item in state.weather!.daily) {
      if (item.temp.day > _graphMaxY) _graphMaxY = item.temp.day;
      if (item.temp.day < _graphMinY) _graphMinY = item.temp.day;

      _data.add(FlSpot(item.dt.toDouble(), item.temp.day));
    }

    return _data;
  }

  List<FlSpot> _initWindSpeedHourly(RemoteWeatherState state) {
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

    return _data;
  }

  List<FlSpot> _initWindSpeedDaily(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.daily[0].dt.toDouble();
    _graphMaxX = state.weather!.daily.last.dt.toDouble();
    _graphMinY = state.weather!.daily[0].windSpeed;
    _graphMaxY = 0;
    for (var item in state.weather!.daily) {
      if (item.windSpeed > _graphMaxY) _graphMaxY = item.windSpeed;
      if (item.windSpeed < _graphMinY) _graphMinY = item.windSpeed;

      _data.add(FlSpot(item.dt.toDouble(), item.windSpeed));
    }

    return _data;
  }

  List<FlSpot> _initWindDegHourly(RemoteWeatherState state) {
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

    return _data;
  }

  List<FlSpot> _initWindDegDaily(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.daily[0].dt.toDouble();
    _graphMaxX = state.weather!.daily.last.dt.toDouble();
    _graphMinY = state.weather!.daily[0].windDeg.toDouble();
    _graphMaxY = 0;
    for (var item in state.weather!.daily) {
      if (item.windDeg > _graphMaxY) _graphMaxY = item.windDeg.toDouble();
      if (item.windDeg < _graphMinY) _graphMinY = item.windDeg.toDouble();

      _data.add(FlSpot(item.dt.toDouble(), item.windDeg.toDouble()));
    }

    return _data;
  }

  List<FlSpot> _initHumidityHourly(RemoteWeatherState state) {
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

    return _data;
  }

  List<FlSpot> _initHumidityDaily(RemoteWeatherState state) {
    List<FlSpot> _data = [];
    _graphMinX = state.weather!.daily[0].dt.toDouble();
    _graphMaxX = state.weather!.daily.last.dt.toDouble();
    _graphMinY = state.weather!.daily[0].humidity.toDouble();
    _graphMaxY = 0;
    for (var item in state.weather!.daily) {
      if (item.humidity > _graphMaxY) _graphMaxY = item.humidity.toDouble();
      if (item.humidity < _graphMinY) _graphMinY = item.humidity.toDouble();

      _data.add(FlSpot(item.dt.toDouble(), item.humidity.toDouble()));
    }

    return _data;
  }

  List<LineTooltipItem> _initTooltipItems(List<LineBarSpot> line) {
    final List<LineTooltipItem> items = [];
    for (var element in line) {
      items.add(
        LineTooltipItem(
          _selectedParam == Params.temperature
              ? Utils.getFormattedTemperatureData(element.x, element.y)
              : _selectedParam == Params.windSpeed
                  ? Utils.getFormattedWindSpeedData(element.x, element.y)
                  : _selectedParam == Params.windDeg
                      ? Utils.getFormattedWindDegData(element.x, element.y)
                      : Utils.getFormattedHumidityData(element.x, element.y),
          AppTextStyles.lightLowText,
        ),
      );
    }
    return items;
  }

  FlLine _flLine(double value) {
    return FlLine(
      color: Colors.white.withOpacity(0.1),
      dashArray: [9, 0, 9],
      strokeWidth: 1,
    );
  }

  LineChartData _data(RemoteWeatherState state) {
    var data = _initData(state);
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
                    color: AppColors.mainLow,
                    radius: 6,
                    strokeWidth: 4,
                    strokeColor: Colors.white,
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
          getTooltipItems: _initTooltipItems,
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
        getDrawingVerticalLine: _flLine,
        getDrawingHorizontalLine: _flLine,
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
          spots: data,
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

  List<RadarEntry>? _initWindDegData(RemoteWeatherState state) {
    List<double> entries = [0, 0, 0, 0, 0, 0, 0, 0];
    if (_selectedPeriod == Period.twoDays) {
      List<Current> data;
      data = state.weather!.hourly;
      for (var i in data) {
        if (i.windDeg > 22.5 && i.windDeg <= 67.5) entries[1]++;
        if (i.windDeg > 67.5 && i.windDeg <= 112.5) entries[2]++;
        if (i.windDeg > 112.5 && i.windDeg <= 157.5) entries[3]++;
        if (i.windDeg > 157.5 && i.windDeg <= 202.5) entries[4]++;
        if (i.windDeg > 202.5 && i.windDeg <= 247.5) entries[5]++;
        if (i.windDeg > 247.5 && i.windDeg <= 292.5) entries[6]++;
        if (i.windDeg > 292.5 && i.windDeg <= 337.5) entries[7]++;
        if (i.windDeg > 337.5 || i.windDeg <= 22.5) entries[0]++;
      }
      List<RadarEntry> result = [];
      for (var i = 0; i < 8; i++) {
        result.add(RadarEntry(value: entries[i]));
      }
      return result;
    } else {
      List<Daily> data;
      data = state.weather!.daily;
      for (var i in data) {
        if (i.windDeg > 22.5 && i.windDeg <= 67.5) entries[1]++;
        if (i.windDeg > 67.5 && i.windDeg <= 112.5) entries[2]++;
        if (i.windDeg > 112.5 && i.windDeg <= 157.5) entries[3]++;
        if (i.windDeg > 157.5 && i.windDeg <= 202.5) entries[4]++;
        if (i.windDeg > 202.5 && i.windDeg <= 247.5) entries[5]++;
        if (i.windDeg > 247.5 && i.windDeg <= 292.5) entries[6]++;
        if (i.windDeg > 292.5 && i.windDeg <= 337.5) entries[7]++;
        if (i.windDeg > 337.5 || i.windDeg <= 22.5) entries[0]++;
      }
      List<RadarEntry> result = [];
      for (var i = 0; i < 8; i++) {
        result.add(RadarEntry(value: entries[i]));
      }
      return result;
    }
  }

  void _onBottomItemChanged(int value, RemoteWeatherState state) {
    setState(() {
      _currentBottomParamIndex = value;
      value == 0
          ? _selectedPeriod = Period.twoDays
          : _selectedPeriod = Period.week;
      _initChart(state);
    });
  }

  void _onTopItemChanged(int value, RemoteWeatherState state) {
    setState(() {
      _currentTopParamIndex = value;
      value == 0
          ? _selectedParam = Params.temperature
          : value == 1
              ? _selectedParam = Params.windSpeed
              : value == 2
                  ? _selectedParam = Params.windDeg
                  : value == 3
                      ? _selectedParam = Params.windDeg
                      : value == 4
                          ? _selectedParam = Params.humidity
                          : Params.temperature;
      _initChart(state);
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
        const SizedBox(height: 15),
        _buildLine(),
        const SizedBox(height: 20),
        SizedBox(
          width: 320,
          height: 80,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 140,
            onSelectedItemChanged: (value) => _onTopItemChanged(value, state),
            children: [
              _paramTopItem('Temperature', 0),
              _paramTopItem('Wind Speed', 1),
              _paramTopItem('Rose Of Winds', 2),
              _paramTopItem('Wind Degrees', 3),
              _paramTopItem('Humidity', 4),
            ],
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          // width: double.infinity,
          width: 320.0,
          height: 250.0,
          child: _dataLoading
              ? SpinKitWave(color: AppColors.mainLow)
              : _currentTopParamIndex != 2
                  ? LineChart(
                      _data(state),
                      swapAnimationDuration: const Duration(milliseconds: 15),
                    )
                  : AppRadarChart(data: _initWindDegData(state)),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: 320,
          height: 80,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 250,
            onSelectedItemChanged: (value) =>
                _onBottomItemChanged(value, state),
            children: [
              _paramBottomItem(Utils.getDateTimePeriodHourly(state), 0),
              _paramBottomItem(Utils.getDateTimePeriodDaily(state), 1),
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
      var minutes = time.minute;
      var minutesToStr = '';
      if (minutes < 10) {
        minutesToStr = '0$minutes';
      } else {
        minutesToStr = minutes.toString();
      }
      _items.add(WeatherItem(
        image: state.weather!.hourly[i].weather[0].image,
        temp: state.weather!.hourly[i].temp,
        time: '${time.hour}:$minutesToStr',
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
              children: const [
                SizedBox(height: 70),
                SpinKitWave(
                  color: Colors.white,
                ),
              ],
            )
          : state is RemoteWeatherDone
              ? Column(
                  children: [
                    const SizedBox(height: 15),
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
                                    'Next Day',
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

  void _resetChart() {
    _currentTopParamIndex = 0;
    _currentBottomParamIndex = 0;
    _selectedPeriod = Period.twoDays;
    _selectedParam = Params.temperature;
  }

  NotificationListener<DraggableScrollableNotification> _buildSheet(
      RemoteWeatherState state) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          _percent = -2 * notification.extent + 0.8;
        });
        if (_percent < -0.3) _initChart(state);
        if (_percent > -0.14) _resetChart();
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
              // : '${Utils.getWeekdayName(date.weekday)}, $day $month',
              : '$day $month',
      style: AppTextStyles.lowDarkS24W400Normal,
    );
  }

  Widget _buildBody(RemoteWeatherState state) {
    return Container(
      color: AppColors.mainMid,
      // color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            state is RemoteWeatherLoading
                ? Container(
                    // color: AppColors.mainLow,
                    color: AppColors.mainScaffold,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 200),
                        SpinKitWave(
                          color: AppColors.mainMid,
                          itemCount: 6,
                        ),
                      ],
                    ),
                  )
                : state is RemoteWeatherDone
                    ? Container(
                        // color: AppColors.mainLow,
                        color: AppColors.mainScaffold,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, top: 10, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildDate(state),
                                      const SizedBox(height: 3),
                                      Text('Polotsk',
                                          style: AppTextStyles.cityName),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 40,
                                    child: FlutterSwitch(
                                      value: _switcherValue,
                                      onToggle: (value) {
                                        setState(() {
                                          _switcherValue = value;
                                        });
                                      },
                                      activeColor: AppColors.mainMid,
                                      inactiveColor: AppColors.mainLow,
                                      toggleSize: 10,
                                      borderRadius: 5,
                                      showOnOff: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 360,
                              width: double.infinity,
                              child: ListWheelScrollViewX(
                                itemExtent: 350,
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
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.mainScaffold,
        systemNavigationBarColor: AppColors.mainScaffold,
        systemNavigationBarDividerColor: AppColors.mainScaffold,
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
