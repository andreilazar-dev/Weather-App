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
  Clouds
}


class Weather {
  int? id;
  WeatherCondition? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
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
}
