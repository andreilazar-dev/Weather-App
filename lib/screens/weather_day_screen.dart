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
      // appBar: AppBar(
      //   title: Text('Weather App'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.settings),
      //       onPressed: () {
      //         //Navigate to settingsScreen
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())
      //         );
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () async {
      //         //navigate to CitySearchScreen
      //         final typedCity =  await Navigator.push(context, MaterialPageRoute(builder: (context) => CitySearchScreen())
      //         );
      //         if(typedCity != null) {
      //           BlocProvider.of<WeatherBloc>(context).add(
      //             WeatherEventRequested(city: typedCity),
      //           );
      //         }
      //       },
      //     )
      //   ],
      // ),
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 60),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'http://openweathermap.org/img/wn/${weather.list?.first.weather
                                      ?.first.icon}@2x.png',
                                  scale: 0.8,
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                weather.city?.name as String,
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
                                'Updated: ${TimeOfDay.fromDateTime(DateTime.parse(weather.list?.first.dtTxt as String)).format(context)}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: themeState.textColor),
                              ),
                            ),
                            Center(
                              child: Text(
                                weather.list?.first.weather?.first.description as String,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.textColor),
                              ),
                            ),
                            //show more here, put together inside a Widget
                            TemperatureWidget(
                              weather: weather.list?.first.main,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 60),
                            ),
                            DayConditionWidget(weather: weather)
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
