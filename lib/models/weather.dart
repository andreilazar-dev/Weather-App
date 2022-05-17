enum WeatherCondition {
  Thunderstorm,
  Drizzle,
  Rain,
  Snow,
  Mist,
  Smoke,
  Haze,
  Dust,
  Fog,
  Sand,
  Ash,
  Squall,
  Tornado,
  Clear,
  Clouds,
  unknown
}

class Weather {
  int? id;
  WeatherCondition? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = _mapStringToWeatherCondition(json['main']);
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'Thunderstorm': WeatherCondition.Thunderstorm,
      'Drizzle': WeatherCondition.Drizzle,
      'Rain': WeatherCondition.Rain,
      'Snow': WeatherCondition.Snow,
      'Mist': WeatherCondition.Mist,
      'Smoke': WeatherCondition.Smoke,
      'Haze': WeatherCondition.Haze,
      'Dust': WeatherCondition.Dust,
      'Fog': WeatherCondition.Fog,
      'Sand': WeatherCondition.Sand,
      'Ash': WeatherCondition.Ash,
      'Squall': WeatherCondition.Squall,
      'Tornado': WeatherCondition.Tornado,
      'Clear': WeatherCondition.Clear,
      'Clouds' :WeatherCondition.Clouds
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
}
