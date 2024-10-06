import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_weather/presentation/application/application.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Application());
}
