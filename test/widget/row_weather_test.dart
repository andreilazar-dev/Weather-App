import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/parameters.dart';
import 'package:weather_app/models/rain.dart';
import 'package:weather_app/models/sys.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/wind.dart';
import 'package:weather_app/widget/row_weather_item.dart';


main() {
  //TODO: fix http request to make a test
  group("Row Weather", () {
    testWidgets('should render properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RowWeatherItem(
              parameters: Parameters(
                  dt: 1653242400,
                  main: Main(),
                  //Empty List can break
                  weather: <Weather>[Weather(
                    id: 501,
                    main: WeatherCondition.Rain ,
                    description: 'moderate rain',
                    icon: '10n',
                  )],
                  clouds: Clouds(),
                  wind: Wind(),
                  visibility: 10000,
                  pop: 0.25,
                  rain: Rain(),
                  sys: Sys(),
                  dtTxt: "2022-05-20 19:00:00"),
            ),
          ),
        ),
      );
      expect(find.text('Friday May 20'), findsOneWidget);
    });
  });
}
