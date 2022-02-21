import 'package:clean_arch_weather/styles_const.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppRadarChart extends StatefulWidget {
  final List<RadarEntry>? data;
  const AppRadarChart({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<AppRadarChart> createState() => _AppRadarChartState();
}

class _AppRadarChartState extends State<AppRadarChart> {
  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        borderData: FlBorderData(border: const Border()),
        radarBackgroundColor: Colors.transparent,
        tickBorderData: BorderSide(color: Colors.white.withOpacity(0.2)),
        radarBorderData: const BorderSide(color: Colors.transparent),
        gridBorderData: const BorderSide(color: Colors.white, width: 0.3),
        tickCount: 7,
        ticksTextStyle: const TextStyle(color: Colors.transparent),
        titleTextStyle: AppTextStyles.midWhiteBold,
        getTitle: (index) {
          switch (index) {
            case 0:
              {
                return 'N';
              }
            case 1:
              {
                return 'NE';
              }
            case 2:
              {
                return 'E';
              }
            case 3:
              {
                return 'SE';
              }
            case 4:
              {
                return 'S';
              }
            case 5:
              {
                return 'SW';
              }
            case 6:
              {
                return 'W';
              }
            case 7:
              {
                return 'NW';
              }
          }
          return 'error';
        },
        dataSets: [
          RadarDataSet(
            fillColor: Colors.white.withOpacity(0.5),
            borderColor: Colors.white,
            borderWidth: 2,
            // borderColor: Colors.transparent,
            entryRadius: 1.0,
            dataEntries: widget.data,
          ),
        ],
      ),
    );
  }
}
