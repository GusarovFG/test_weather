import 'package:flutter/material.dart';
import 'package:test_weather/presentation/auth_screen/auth_screen.dart';
import 'package:test_weather/data/services/firebase_service/firebase_service.dart';
import 'package:test_weather/presentation/weather_screen/weather_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final FirebaseService firebase = FirebaseService();

  @override
  void initState() {
    super.initState();
    firebase.onListenUser((user) {
      if (user == null) {
        Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (_) => AuthScreen(isLogin: false),
          ),
        );
      } else {
        print('user $user');
        Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (_) => const WeatherScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Cruinn'),
      home: Scaffold(
          body: AuthScreen(
        isLogin: false,
      )),
    );
  }
}
