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

  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

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
              final weekWeather = weatherState.weekWeather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                          WeatherEventRefresh(
                              lat:
                                  weekWeather.city?.coord?.lat.toString() as String,
                              lon: weekWeather.city?.coord?.lon.toString()
                                  as String));
                      return _completer.future;
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blueAccent,
                            Color.fromRGBO(254, 250, 224, 1),
                          ],
                        )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 60),
                          child: ListView(
                            children: List.generate(weekWeather.list?.length ?? 0,
                                (index) {
                              if (index == 0 ||
                                  notSameDay(
                                      weekWeather.list?[index].dtTxt as String,
                                      weekWeather.list?[index - 1].dtTxt
                                          as String)) {
                                return RowWeather(
                                    parameters: weekWeather.list![index],
                                    textColor: themeState.textColor);
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
