import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/week_weather.dart';
import '../blocs/setting_bloc.dart';
import '../blocs/theme_bloc.dart';
import '../models/weather.dart';
import '../states/setting_state.dart';
import '../states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final WeekWeather weather;
  //constructor
  TemperatureWidget({required this.weather})
      :assert(weather != null);

  // BoxedIcon _mapWeatherConditionToIcon({required WeatherCondition weatherCondition}) {
  //   switch(weatherCondition) {
  //     case WeatherCondition.Clear:
  //     case WeatherCondition.Clouds:
  //       return BoxedIcon(WeatherIcons.day_sunny);
  //       break;
  //     case WeatherCondition.Snow
  //       return BoxedIcon(WeatherIcons.snow);
  //       break;
  //     case WeatherCondition.Rain:
  //       return BoxedIcon(WeatherIcons.cloud_up);
  //       break;
  //     case WeatherCondition.Rain:
  //     case WeatherCondition.Tornado:
  //       return BoxedIcon(WeatherIcons.rain);
  //       break;
  //   }
  //   return BoxedIcon(WeatherIcons.sunset);
  // }
  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Add an icon here
            //_mapWeatherConditionToIcon(weatherCondition: weather.),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Min temp: ${weather.list?.first.main?.tempMin}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _themeState.textColor,
                          ),
                        ),
                        Text('Temp: ${weather.list?.first.main?.temp}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _themeState.textColor,
                          ),
                        ),
                        Text('Max temp: ${weather.list?.first.main?.tempMax}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _themeState.textColor,
                          ),
                        ),
                      ],
                    );
                  },
                )
            )
          ],
        )
      ],
    );
  }

}