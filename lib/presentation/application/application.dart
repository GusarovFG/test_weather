import 'package:flutter/material.dart';
import 'package:test_weather/presentation/auth_screen/auth_screen.dart';
import 'package:test_weather/services/firebase_servise/firebase_servise.dart';
import 'package:test_weather/weather_screen/weather_screen.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final FirebaseServise firebase = FirebaseServise();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    firebase.onListenUser((user) {
      if (user == null) {
        // Navigator.push(navigatorKey.currentContext!,
        //     MaterialPageRoute(builder: (_) => AuthScreen(isLogin: false)));
      } else {
        print('user $user');
        // Navigator.push(navigatorKey.currentContext!,
        //     MaterialPageRoute(builder: (_) => const WeatherScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
          body: AuthScreen(
        isLogin: false,
      )),
    );
  }
}
