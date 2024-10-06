import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_weather/presentation/application/application.dart';
import 'package:test_weather/services/shared_preferences_service/shared_preferences_service.dart';
import 'services/firebase_service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesServiceImpl().init();
  runApp(const Application());
}
