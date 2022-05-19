import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/parameters.dart';

class RowWeather extends StatelessWidget {

  Color textColor;
  Parameters weather;

  RowWeather({Key? key , this.textColor = Colors.white , required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE MMM d').format(
                  DateTime.parse(weather.dtTxt as String)),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            Text(
                weather.weather?.first
                    .description as String,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor))
          ],
        ),
        Row(
          children: [
            Image.network(
              'http://openweathermap.org/img/wn/${weather.weather?.first.icon}@2x.png',
            ),
            Column(
              children: [
                Text(
                  '${weather.main?.tempMax}°C '
                      .toString() as String,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Text(
                  '${weather.main?.tempMin}°C'
                      .toString() as String,
                  style: TextStyle(
                      fontSize: 12,
                      color: textColor),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

