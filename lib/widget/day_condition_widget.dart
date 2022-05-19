import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widget/temperatureWidget.dart';

import '../main.dart';
import '../models/week_weather.dart';

class DayConditionWidget extends StatelessWidget {
  final WeekWeather weather;

  const DayConditionWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: List.generate(
            4,
            (index) => Expanded(
                  child: GestureDetector(
                      onTap: () => print('Tapped:$index'),
                      child: Container(
                          height: 160,
                          child: Column(
                            children: [
                              Text(
                                  TimeOfDay.fromDateTime(DateTime.parse(
                                      weather.list?[index].dtTxt as String))
                                      .format(context),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 90,
                                child: Image.network(
                                  'http://openweathermap.org/img/wn/${weather.list?[index].weather?.first.icon}@2x.png',
                                ),
                              ),
                              TemperatureWidget(weather: weather.list?[index].main , headFontSize: 18,minFontSize: 10,)
                            ],
                          ))),
                )),
      ),
    );
  }
}
