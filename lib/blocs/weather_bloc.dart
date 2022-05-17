import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/week_weather.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final Weatherrepository weatherrepository;
  WeatherBloc({required this.weatherrepository}):
      assert(weatherrepository != null),
      super(WeatherStateInitial());
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async*{
    if(weatherEvent is WeatherEventRequested){
      yield WeatherStateLoading();
      try{
        final WeekWeather weekWeather = await weatherrepository.getWeekWeather(weatherEvent.city);
        yield WeatherStateSuccess(weekWeather: weekWeather);
      }catch(exception){
        yield WeatherStateFailure();
      }
    }else if (weatherEvent is WeatherEventRefresh) {
      try{
        final WeekWeather weekWeather = await weatherrepository.getWeekWeather(weatherEvent.city);
        yield WeatherStateSuccess(weekWeather: weekWeather);
      }catch(exception){
        yield WeatherStateFailure();
      }
    }
  }
}