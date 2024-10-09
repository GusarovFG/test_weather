import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:test_weather/data/services/location_service/location_service.dart';
import 'package:test_weather/domain/models/weather_model.dart';
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
      await LocationService().getLocation();
      final currentWeather = await WeatherRepository.getWeather();
      print(currentWeather.name);
      emit(WeatherSuccess(currentWeather));
    } catch (e) {
      emit(WeatherFailure());
      print(e);
    }
  }
}
