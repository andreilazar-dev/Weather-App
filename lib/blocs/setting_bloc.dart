
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/settings_event.dart';
import 'package:weather_app/states/setting_state.dart';

class SettingsBloc extends Bloc<SettingEvent,SettingsState>{
  SettingsBloc():super (SettingsState(temperatureUnit: TemperatureUnit.Celsius));

  Stream<SettingsState> mapEventToState(SettingEvent settingsEvent) async*{
    if(settingsEvent is SettingsEventToggleUnit){
      yield SettingsState(temperatureUnit: state.temperatureUnit == TemperatureUnit.Celsius ? TemperatureUnit.Fahrenheit: TemperatureUnit.Celsius);
  }
  }
}