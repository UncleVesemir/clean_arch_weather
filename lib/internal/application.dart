import 'package:clean_arch_weather/presentation/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
