import 'package:equatable/equatable.dart';
import 'package:weather_app/models/parameters.dart';

import 'city.dart';

class WeekWeather  extends Equatable {
  String? cod;
  int? message;
  int? cnt;
  List<Parameters>? list;
  City? city;

  WeekWeather({this.cod, this.message, this.cnt, this.list, this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [
  cod,
  message,
  cnt,
  list,
  city,
  ];

  //Convert from JSON
  WeekWeather.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <Parameters>[];
      json['list'].forEach((v) {
        list!.add(Parameters.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}




