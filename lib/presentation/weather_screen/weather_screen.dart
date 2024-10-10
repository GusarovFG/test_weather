import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_weather/data/services/firebase_service/firebase_service.dart';
import 'package:test_weather/presentation/map_screen/map_screen.dart';
import 'package:test_weather/presentation/weather_screen/current_weather_screen.dart';
import 'package:test_weather/presentation/weather_screen/weather_bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final FirebaseService prefs = FirebaseService();
  final bloc = WeatherBloc();

  @override
  void initState() {
    bloc.add(WeatherLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => FirebaseService().logOut(),
          icon: const Icon(Icons.logout_sharp),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MapScreen()));
              },
              icon: Icon(Icons.map))
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: bloc,
        listener: (BuildContext context, WeatherState state) {},
        listenWhen: (previous, current) => current is WeatherLoading,
        buildWhen: (previous, current) => current is WeatherSuccess,
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case WeatherSuccess:
              final succ = state as WeatherSuccess;
              return CurrentWeatherScreen(weather: succ.weather);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
