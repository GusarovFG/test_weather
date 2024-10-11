import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:test_weather/domain/models/weather_models/weather_model.dart';
import 'package:test_weather/domain/repository/network_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherLoadEvent>(weatherLoading);
  }

  FutureOr<void> weatherLoading(
      WeatherLoadEvent event, Emitter<WeatherState> emit) async {
    try {
      final currentWeather = await WeatherRepository.getWeather();
      if (currentWeather != null) {
        emit(WeatherSuccess(currentWeather));
      } else {
        emit(WeatherFailure());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
