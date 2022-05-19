import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/theme_bloc.dart';
import '../models/main.dart';
import '../states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Main? mainWeather;

  double minFontSize;
  double headFontSize;

  //constructor
  TemperatureWidget(
      {required this.mainWeather, this.headFontSize = 25, this.minFontSize = 14})
      : assert(mainWeather != null);

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            '${mainWeather?.temp} °C',
            style: TextStyle(
              fontSize: headFontSize,
              fontWeight: FontWeight.bold,
              color: _themeState.textColor,
            ),
          ),
        ),
        Text(
          'Min temp: ${mainWeather?.tempMin} °C',
          style: TextStyle(
            fontSize: minFontSize,
            color: _themeState.textColor,
          ),
        ),
        Text(
          'Max temp: ${mainWeather?.tempMax} °C',
          style: TextStyle(
            fontSize: minFontSize,
            color: _themeState.textColor,
          ),
        ),
      ],
    );
  }
}
