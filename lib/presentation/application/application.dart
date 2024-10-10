import 'package:flutter/material.dart';
import 'package:test_weather/data/services/firebase_service/firebase_auth_service/firebase_service.dart';
import 'package:test_weather/presentation/auth_screen/authentication_bloc/authentication_bloc_screen.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Cruinn'),
      home: const Scaffold(body: AuthenticationBlocScreen()),
    );
  }
}
