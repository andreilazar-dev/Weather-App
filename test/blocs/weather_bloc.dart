import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/week_weather.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

import 'weather_bloc.mocks.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

@GenerateMocks([WeatherRepositoryMock])
main() async {
  group('WeatherBloc', () {
    late MockWeatherRepositoryMock weatherRepositoryMock;

    late WeatherBloc weatherBloc;

    setUp(() {
      weatherRepositoryMock = MockWeatherRepositoryMock();
      weatherBloc = WeatherBloc(weatherRepository: weatherRepositoryMock);
    });

    tearDown(() {
      weatherBloc.close();
    });

    test('initial state is WeatherStateInitial', () {
      expect(weatherBloc.state, WeatherStateInitial());
    });

    blocTest(
      'WeatherEventRequested',
      build: () {
        when(weatherRepositoryMock.getWeekWeatherByName('Rome')).thenAnswer(
            (_) => Future.value(WeekWeather(
                cod: "test1",
                message: 1,
                city: City(),
                cnt: 2,
                list: List.empty())));
        return weatherBloc;
      },
      act: (WeatherBloc bloc) =>
          bloc.add(const WeatherEventRequested(city: 'Rome')),
      expect: () => [
        WeatherStateLoading(),
        WeatherStateSuccess(weekWeather: WeekWeather(
            cod: "test1",
            message: 1,
            city: City(),
            cnt: 2,
            list: List.empty()))
      ],
    );

    blocTest(
      'WeatherEventRefresh',
      build: () {
        when(weatherRepositoryMock.getWeekWeather('10','20')).thenAnswer(
                (_) => Future.value(WeekWeather(
                cod: "test",
                message: 1,
                city: City(),
                cnt: 2,
                list: List.empty())));
        return weatherBloc;
      },
      act: (WeatherBloc bloc) =>
          bloc.add(const WeatherEventRefresh(lat: '10' ,lon: '20')),
      expect: () => [
        WeatherStateSuccess(weekWeather: WeekWeather(
            cod: "test",
            message: 1,
            city: City(),
            cnt: 2,
            list: List.empty()))
      ],
    );
  });


}
