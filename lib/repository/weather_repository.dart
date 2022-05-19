import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/week_weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String token = dotenv.get('SECRET_API_KEY');
const baseUrl = 'https://api.openweathermap.org';
final weatherCityURl = (String cityName) =>
    '$baseUrl/data/2.5/forecast?q=${cityName}&appid=${token}&units=metric';
final weatherURL = (String lat, String lon) =>
    '$baseUrl/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${token}&units=metric';

//final cityUrl = (String cityName) =>'$baseUrl/geo/1.0/direct?q=${cityName}&limit=5&appid=${token}';
//&units=metric
//standard, metric and imperial
class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({required this.httpClient}) : assert(httpClient != null);

  //Give all week weather using City name
  Future<WeekWeather> getWeekWeatherByName(String cityName) async {
    final response = await httpClient.get(Uri.parse(weatherCityURl(cityName)));

    if (response.statusCode == 200) {
      final weatherJson = jsonDecode(response.body);
      return WeekWeather.fromJson(weatherJson);
    } else {
      throw Exception('Error getting week weather of : ${cityName}');
    }
  }

  //Give all week weather using lat and lon
  Future<WeekWeather> getWeekWeather(String lat, String lon) async {
    final response = await httpClient.get(Uri.parse(weatherURL(lat, lon)));
    if (response.statusCode == 200) {
      final weatherJson = jsonDecode(response.body);
      return WeekWeather.fromJson(weatherJson);
    } else {
      throw Exception('Error getting week weather ');
    }
  }
}
