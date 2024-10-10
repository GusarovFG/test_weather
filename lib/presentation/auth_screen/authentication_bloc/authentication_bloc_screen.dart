import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_weather/presentation/auth_screen/auth_screen.dart';
import 'package:test_weather/presentation/weather_screen/weather_screen.dart';

class AuthenticationBlocScreen extends StatelessWidget {
  const AuthenticationBlocScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const WeatherScreen();
          } else {
            return AuthScreen(
              isLogin: false,
            );
          }
        },
      ),
    );
  }
}
