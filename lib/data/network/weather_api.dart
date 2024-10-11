import 'package:dio/dio.dart';
import 'package:test_weather/data/network/api_key.dart';
import 'package:test_weather/domain/models/weather_models/weather_model.dart';

abstract class WeatherApi {
  //Метод для получение погоды
  Future<Weather?> fetchWeather({required String lon, required String lat});
}

//Синглтон для работы с api OpenWeatherMap
class WeatherApiImpl implements WeatherApi {
  static final WeatherApiImpl _singleton = WeatherApiImpl._internal();
  factory WeatherApiImpl() => WeatherApiImpl._singleton;
  WeatherApiImpl._internal();

  //Данные о погоде
  Weather? weatherData;

  //Dio сервис
  final Dio _dio = Dio();
  //apikey для openWeatherMap
  final String _apiKey = apiKey;

  @override
  Future<Weather?> fetchWeather(
      {required String lon, required String lat}) async {
    var response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru');
    var json = Weather.fromJson(response.data);
    weatherData = json;
    return weatherData!;
  }
}
