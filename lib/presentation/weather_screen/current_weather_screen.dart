import 'package:flutter/material.dart';
import 'package:test_weather/domain/models/weather_model.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final Weather weather;
  const CurrentWeatherScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.name,
            style: const TextStyle(fontSize: 40),
          ),
          WeatherType(code: weather.weather.first.id).getWeatherImage(),
          Text(
            '${weather.main.temp.round()} °C',
            style: const TextStyle(fontSize: 90),
          ),
          Text(
            weather.weather.first.description,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.accessibility_new_sharp),
                  const Text('Ощущается как'),
                  Text('${weather.main.feelsLike.round()} °C'),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.waves_outlined),
                  const Text('Влажность'),
                  Text('${weather.main.humidity} %'),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.wind_power_sharp),
                  const Text('Скорость ветра'),
                  Text('${weather.wind.speed} м/с'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherType {
  int code;
  WeatherType({required this.code});

  Image getWeatherImage() {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/thunder.png');
      case >= 300 && < 400:
        return Image.asset('assets/rain.png');
      case >= 500 && < 600:
        return Image.asset('assets/heavyRain.png');
      case >= 600 && < 700:
        return Image.asset('assets/snow.png');
      case >= 700 && < 800:
        return Image.asset('assets/cloud.png');
      case >= 801 && < 805:
        return Image.asset('assets/cloudy.png');
      default:
        return Image.asset('assets/sun.png');
    }
  }
}
