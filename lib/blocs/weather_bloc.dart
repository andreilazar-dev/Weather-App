import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/week_weather.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherrepository;

  WeatherBloc({required this.weatherrepository})
      : assert(weatherrepository != null),
        super(WeatherStateInitial()) {
    on<WeatherEvent>(mapEventToState);
  }

  Future<void> mapEventToState(
      WeatherEvent weatherEvent, Emitter<WeatherState> emit) async {
    if (weatherEvent is WeatherEventRequested) {
      emit(WeatherStateLoading());
      try {
        final WeekWeather weekWeather =
            await weatherrepository.getWeekWeatherByName(weatherEvent.city);
        emit(WeatherStateSuccess(weekWeather: weekWeather));
      } catch (exception) {
        emit(WeatherStateFailure());
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final WeekWeather weekWeather = await weatherrepository.getWeekWeather(
            weatherEvent.lat, weatherEvent.lon);
        emit(WeatherStateSuccess(weekWeather: weekWeather));
      } catch (exception) {
        emit(WeatherStateFailure());
      }
    }
  }
}
