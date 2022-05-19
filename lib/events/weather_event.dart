import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent {
  final String city;

  const WeatherEventRequested({required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String lat;
  final String lon;

  const WeatherEventRefresh({required this.lat, required this.lon})
      : assert(lat != null && lon != null);

  @override
  List<Object?> get props => [lat, lon];
}
