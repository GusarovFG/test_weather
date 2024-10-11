part of 'weather_bloc.dart';

sealed class WeatherState {}

abstract class WeatherActionState extends WeatherState {}

final class WeatherInitial extends WeatherActionState {}

final class WeatherLoading extends WeatherActionState {}

final class WeatherFailure extends WeatherActionState {}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  WeatherSuccess(this.weather);
}
