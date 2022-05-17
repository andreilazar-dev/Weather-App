import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_bloc_observer.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/states/theme_state.dart';

import 'blocs/setting_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use blocs...
    },
    blocObserver: WeatherBlocObserver(),
  );
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(),
      )
    ],
    child: MyApp(weatherrepository: weatherRepository),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherrepository;

  MyApp({Key? key, required this.weatherrepository})
      : assert(weatherrepository != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState){
      return MaterialApp(
        title: 'weather_app',
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherrepository: weatherrepository),
          child: const WeatherScreen(),
        ),
      );
    },
    );
  }
}
