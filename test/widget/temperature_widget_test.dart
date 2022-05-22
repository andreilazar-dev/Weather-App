import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/screens/root_screen.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:weather_app/widget/temperatureWidget.dart';

import '../blocs/weather_bloc.dart';
import '../blocs/weather_bloc.mocks.dart';

void main() {

  //TODO: need more configuration to run

  group('Temperature Widget', () {

    late MockWeatherRepositoryMock weatherRepositoryMock;

    setUp((){
      weatherRepositoryMock = MockWeatherRepositoryMock();
    });



    Widget createWidgetUnderTest(){
      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState){
        return MaterialApp(
          title: 'weather_app',
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepositoryMock),
            child: TemperatureWidget(
              mainWeather: Main(
                temp: 29.49,
                feelsLike: 30.00,
                tempMin: 25.4,
                tempMax: 29.49,
                pressure: 1009,
                seaLevel: 1009,
                grndLevel: 1004,
                humidity: 48,
                tempKf: 4.09,
              ),
            ),
          ),
        );
      },
      );
    }


    testWidgets('should rendet propery with temp', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.text('29.49'), findsOneWidget);
    });
  });
}
