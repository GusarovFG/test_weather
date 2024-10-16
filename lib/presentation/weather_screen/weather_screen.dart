import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_weather/data/services/firebase_service/firebase_auth_service/firebase_service.dart';
import 'package:test_weather/presentation/map_screen/map_screen.dart';
import 'package:test_weather/presentation/weather_screen/current_weather_screen.dart';
import 'package:test_weather/presentation/weather_screen/weather_bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  final String id = 'WeatherScreen';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final FirebaseServiceImpl prefs = FirebaseServiceImpl();
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
          onPressed: () => FirebaseServiceImpl().logOut(),
          icon: const Icon(Icons.logout_sharp),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapScreen()));
              },
              icon: const Icon(Icons.map))
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: bloc,
        listener: (BuildContext context, WeatherState state) {
          if (state.runtimeType is WeatherFailure) {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: const Text('Упс!'),
                    children: [
                      const Text(
                        'Что-то пошло не так...',
                      ),
                      FilledButton(
                        onPressed: () {
                          bloc.add(WeatherLoadEvent());
                          Navigator.pop(context);
                        },
                        child: const Text('Повторить'),
                      )
                    ],
                  );
                });
          }
        },
        listenWhen: (previous, current) => current is WeatherLoading,
        buildWhen: (previous, current) => current is WeatherSuccess,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (WeatherSuccess):
              final succsess = state as WeatherSuccess;
              return CurrentWeatherScreen(weather: succsess.weather);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
