import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/widget/row_weather.dart';

import '../blocs/theme_bloc.dart';
import '../blocs/weather_bloc.dart';
import '../events/theme_event.dart';
import '../events/weather_event.dart';
import '../models/weather.dart';
import '../states/theme_state.dart';
import '../states/weather_state.dart';


class WeatherWeekScreen extends StatefulWidget {
  const WeatherWeekScreen({Key? key}) : super(key: key);

  @override
  State<WeatherWeekScreen> createState() => _WeatherWeekScreenState();
}

class _WeatherWeekScreenState extends State<WeatherWeekScreen> {
  late Completer<void> _completer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherCondition: weatherState.weekWeather.list?.first.weather
                      ?.first.main as WeatherCondition));
              _completer.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weekWeather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                          WeatherEventRefresh(city: weather.city as String));
                      return _completer.future;
                    },
                    child: Container(
                        color: themeState.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 60),
                          child: ListView(
                            children: List.generate(weather.list?.length ?? 0,
                                (index) {
                              if (index == 0 ||
                                  notSameDay(
                                      weather.list?[index].dtTxt as String,
                                      weather.list?[index - 1].dtTxt
                                          as String)) {
                                return RowWeather(weather: weather.list![index] , textColor: themeState.textColor);
                              }
                              return Container();
                            }),
                          ),
                        )),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return const Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              );
            }
            return const Center(
              child: Text(
                'select a location first !',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }

  bool notSameDay(String date1, String date2) {
    DateTime from = DateTime.parse(date1);
    DateTime to = DateTime.parse(date2);
    return daysBetween(from, to) != 0;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
