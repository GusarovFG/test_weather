import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_weather/data/network/weather_api.dart';
import 'package:test_weather/presentation/application/application.dart';
import 'package:test_weather/data/services/shared_preferences_service/shared_preferences_service.dart';
import 'data/services/firebase_service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesServiceImpl().init();
  await WeatherApiImpl().fetchWeather(lon: '53.211093', lat: '56.842447');
  runApp(const Application());
}
