import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/parameters.dart';

class RowWeather extends StatelessWidget {
  Color textColor;
  Parameters parameters;

  RowWeather({Key? key, this.textColor = Colors.white, required this.parameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE MMM d')
                  .format(DateTime.parse(parameters.dtTxt as String)),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
            Text(parameters.weather?.first.description as String,
                style: TextStyle(fontSize: 16, color: textColor))
          ],
        ),
        Row(
          children: [
            Image.network(
              'http://openweathermap.org/img/wn/${parameters.weather?.first.icon}@2x.png',
            ),
            Column(
              children: [
                Text(
                  '${parameters.main?.tempMax}°C '.toString() as String,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Text(
                  '${parameters.main?.tempMin}°C'.toString() as String,
                  style: TextStyle(fontSize: 12, color: textColor),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
