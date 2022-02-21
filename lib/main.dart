import 'package:clean_arch_weather/injector.dart';
import 'package:clean_arch_weather/internal/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const Application());
}
