import 'package:equatable/equatable.dart';
import 'package:weather_app/models/week_weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  List<Object?> get props => [];
}

class WeatherStateInitial extends WeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final WeekWeather weekWeather;

  const WeatherStateSuccess({required this.weekWeather})
      : assert(weekWeather != null);

  List<Object?> get props => [weekWeather];
}

class WeatherStateFailure extends WeatherState {}
