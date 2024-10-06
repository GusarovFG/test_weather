import 'package:flutter/material.dart';
import 'package:test_weather/data/services/firebase_service/firebase_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final FirebaseService prefs = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: FilledButton(
          onPressed: () {
            FirebaseService().logOut();
          },
          child: Icon(Icons.logout),
        ),
      ),
    ));
  }
}
