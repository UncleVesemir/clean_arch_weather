import 'package:equatable/equatable.dart';

class Temperature extends Equatable {
  const Temperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  @override
  List<Object?> get props {
    return [
      day,
      min,
      max,
      night,
      eve,
      morn,
    ];
  }
}
