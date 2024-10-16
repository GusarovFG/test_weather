import 'package:test_weather/data/network/weather_api.dart';
import 'package:test_weather/data/services/location_service/location_service.dart';
import 'package:test_weather/domain/models/weather_models/weather_model.dart';

class WeatherRepository {
  //Метод получения природы
  static Future<Weather?> getWeather() async {
    final locationService = await LocationServiceImpl().getLocation();
    final lon = locationService?.longitude ?? 0;
    final lat = locationService?.latitude ?? 0;

    Weather? currantWeather = await WeatherApiImpl()
        .fetchWeather(lon: lon.toString(), lat: lat.toString());
    if (currantWeather != null) {
      return currantWeather;
    } else {
      return null;
    }
  }
}
