
//I choose this model name for one reason because in api json is called  same

import 'package:equatable/equatable.dart';

class Main  extends Equatable{
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  num? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    data['humidity'] = this.humidity;
    data['temp_kf'] = this.tempKf;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    temp,
    feelsLike,
    tempMin,
    tempMax,
    pressure,
    seaLevel,
    grndLevel,
    humidity,
    tempKf
  ];
}
