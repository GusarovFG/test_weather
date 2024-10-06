import 'dart:convert';

import 'package:test_weather/domain/models/coord_model.dart';
import 'package:test_weather/domain/models/main_model.dart';
import 'package:test_weather/domain/models/weather_element_model.dart';
import 'package:test_weather/domain/models/wind_model.dart';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  final Coord coord;
  final List<WeatherElement> weather;
  final Main main;
  final Wind wind;
  final String name;
  final int cod;

  Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: Coord.fromJson(json["coord"]),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "name": name,
        "cod": cod,
      };
}
