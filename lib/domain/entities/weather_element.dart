import 'package:equatable/equatable.dart';

class WeatherElement extends Equatable {
  const WeatherElement({
    required this.id,
    required this.main,
    required this.description,
  });

  final int id;
  final String main;
  final String description;

  @override
  List<Object> get props {
    return [
      id,
      main,
      description,
    ];
  }
}
