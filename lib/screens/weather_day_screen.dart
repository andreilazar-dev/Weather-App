import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/weather_state.dart';
import 'package:weather_app/widget/day_condition_widget.dart';

import '../blocs/theme_bloc.dart';
import '../states/theme_state.dart';
import '../widget/temperatureWidget.dart';

class WeatherDayScreen extends StatefulWidget {
  const WeatherDayScreen({Key? key}) : super(key: key);

  @override
  State<WeatherDayScreen> createState() => _WeatherDayScreenState();
}

class _WeatherDayScreenState extends State<WeatherDayScreen> {
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
                          themeState.backgroundColor,
                          Color.fromRGBO(254, 250, 224, 1),
                        ],
                      )),
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 60),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'http://openweathermap.org/img/wn/${weekWeather.list?.first.weather?.first.icon}@2x.png',
                                scale: 0.8,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              weekWeather.city?.name as String,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          Center(
                            child: Text(
                              'Updated: ${TimeOfDay.fromDateTime(DateTime.parse(weekWeather.list?.first.dtTxt as String)).format(context)}',
                              style: TextStyle(
                                  fontSize: 12, color: themeState.textColor),
                            ),
                          ),
                          Center(
                            child: Text(
                              weekWeather.list?.first.weather?.first.description
                                  as String,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor),
                            ),
                          ),
                          //show more here, put together inside a Widget
                          TemperatureWidget(
                            mainWeather: weekWeather.list?.first.main,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 60),
                          ),
                          DayConditionWidget(weekWeather: weekWeather)
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              );
            }
            return Center(
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
}
