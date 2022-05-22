import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //initial state
  ThemeBloc()
      : super(const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white)) {
    on<ThemeEvent>(mapEventToState);
  }

  Future<void> mapEventToState(
      ThemeEvent themeEvent, Emitter<ThemeState> emit) async {
    ThemeState newThemeState;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      Color backgroundcolor;
      Color textColor;

      debugPrint(weatherCondition.name);
      switch (weatherCondition) {
        case WeatherCondition.Clear:
          backgroundcolor = Colors.orangeAccent;
          textColor = Colors.black;
          break;
        case WeatherCondition.Clouds:
          backgroundcolor = Colors.blue;
          textColor = Colors.black;
          break;
        case WeatherCondition.Mist:
          backgroundcolor = Colors.lightBlueAccent;
          textColor = Colors.black;
          break;
        case WeatherCondition.Snow:
          backgroundcolor = const Color.fromRGBO(162, 210, 255, 1);
          textColor = Colors.black;
          break;
        case WeatherCondition.Rain:
          backgroundcolor = const Color.fromRGBO(69, 123, 157, 1);
          textColor = Colors.black;
          break;
        case WeatherCondition.Thunderstorm:
        case WeatherCondition.Drizzle:
        case WeatherCondition.Squall:
        case WeatherCondition.Tornado:
        case WeatherCondition.Ash:
        case WeatherCondition.Fog:
        case WeatherCondition.Dust:
        case WeatherCondition.Smoke:
          backgroundcolor = Colors.black12;
          textColor = Colors.black;
          break;
        default:
          backgroundcolor = const Color.fromRGBO(254, 250, 224, 1);
          textColor = Colors.black;
          break;
      }

      newThemeState = ThemeState(
        backgroundColor: backgroundcolor,
        textColor: textColor,
      );

      emit(newThemeState);
    }
  }
}
