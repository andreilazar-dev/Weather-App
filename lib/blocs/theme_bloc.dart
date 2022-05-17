import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  //initial state
  ThemeBloc():
      super(ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white));
  
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async*{
    ThemeState newThemeState;
    if(themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      if(weatherCondition == WeatherCondition.Clear){
        newThemeState = ThemeState(
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
        );
        }
      else if (weatherCondition == WeatherCondition.Clouds){
        newThemeState = ThemeState(
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
      }else {
        newThemeState = ThemeState(
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }

      yield newThemeState;
    }
  }
  }