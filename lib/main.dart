import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_bloc_observer.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/root_screen.dart';
import 'package:weather_app/states/theme_state.dart';
import 'blocs/navigation_cubit.dart';
import 'blocs/setting_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  BlocOverrides.runZoned(
    () {
      // Use blocs...
    },
    blocObserver: WeatherBlocObserver(),
  );
  await dotenv.load(fileName: ".env");
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit()
      ),
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
          child: RootScreen(),
        ),
      );
    },
    );
  }
}
