
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/week_weather.dart';


/*
API CALL
token: b76c05411c5d44e0a09bd9b7c8802eeb
api call by city : api.openweathermap.org/data/2.5/forecast?q={city name}&appid= b76c05411c5d44e0a09bd9b7c8802eeb

5 day call : api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}

example: api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=b76c05411c5d44e0a09bd9b7c8802eeb

 */

const token = 'b76c05411c5d44e0a09bd9b7c8802eeb';
const baseUrl = 'https://api.openweathermap.org';
final weatherURl = (String cityName) =>'$baseUrl/data/2.5/forecast?q=${cityName}&appid=${token}';
//&units=metric
//standard, metric and imperial
class Weatherrepository {
  final http.Client httpClient;

  Weatherrepository({required this.httpClient}): assert (httpClient != null);


  Future<WeekWeather> getWeekWeather(String cityName) async {
    final response = await httpClient.get(Uri.parse(weatherURl(cityName)));

    if(response.statusCode == 200 ){
        return jsonDecode(response.body) as WeekWeather;
    }else{
      throw Exception('Error getting week weather of : ${cityName}');
    }
  }

}