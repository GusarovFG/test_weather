import 'package:dio/dio.dart';
import 'package:test_weather/domain/models/weather_model.dart';

abstract class WeatherApi {
  Future<void> fetchWeather({required String lon, required String lat});
}

class WeatherApiImpl implements WeatherApi {
  static final WeatherApiImpl _singleton = WeatherApiImpl._internal();
  factory WeatherApiImpl() => WeatherApiImpl._singleton;
  WeatherApiImpl._internal();

  late final Weather currentWeather;

  final Dio _dio = Dio();
  final String apiKey = '13b0da2f8181d5d562c9e052e0aa5d0d';

  @override
  Future<void> fetchWeather({required String lon, required String lat}) async {
    try {
      Response response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=ru');

      if (response.data != null) {
        currentWeather = Weather.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      } else {
        print(e);
      }
    }
  }
}
