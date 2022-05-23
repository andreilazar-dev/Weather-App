import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/week_weather.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherStateInitial()) {
    on<WeatherEvent>(mapEventToState);
  }

  Future<void> mapEventToState(
      WeatherEvent weatherEvent, Emitter<WeatherState> emit) async {
    if (weatherEvent is WeatherEventRequested) {
      emit(WeatherStateLoading());
      try {
        final WeekWeather weekWeather =
            await weatherRepository.getWeekWeatherByName(weatherEvent.city);
        emit(WeatherStateSuccess(weekWeather: weekWeather));
      } catch (exception) {
        if(exception is HttpException){
          emit(WeatherStateNotFound());
        }else {
          emit(WeatherStateFailure());
        }
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final WeekWeather weekWeather = await weatherRepository.getWeekWeather(
            weatherEvent.lat, weatherEvent.lon);
        emit(WeatherStateSuccess(weekWeather: weekWeather));
      } catch (exception) {
        emit(WeatherStateFailure());
      }
    }
  }
}
