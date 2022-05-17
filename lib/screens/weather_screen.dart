import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/setting_screen.dart';
import 'package:weather_app/states/weather_state.dart';

import '../blocs/theme_bloc.dart';
import '../states/theme_state.dart';
import '../widget/temperatureWidget.dart';
import 'city_search_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Completer<void> _completer;

  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //Navigate to settingsScreen
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              //navigate to CitySearchScreen
              final typedCity =  await Navigator.push(context, MaterialPageRoute(builder: (context) => CitySearchScreen())
              );
              if(typedCity != null) {
                BlocProvider.of<WeatherBloc>(context).add(
                  WeatherEventRequested(city: typedCity),
                );
              }
            },
          )
        ],
      ),
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
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Text(
                                weather.city?.name as String,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.textColor),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                              ),
                              Center(
                                child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(DateTime.parse(weather.list?.first.dtTxt as String)).format(context)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: themeState.textColor),
                                ),
                              ),
                              //show more here, put together inside a Widget
                              TemperatureWidget(
                                weather: weather,
                              )
                            ],
                          )
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
