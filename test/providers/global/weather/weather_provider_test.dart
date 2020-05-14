import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weatherapp/providers/global/weather/weather_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final WeatherProvider weatherProvider = WeatherProvider(
    openWeatherApiKey: "0000",
    openWeatherEndpoint: "https://api.openweathermap.org/data/2.5/",
    temperatureUnits: "metric",
  );

  test("Should fetch current weather.", () async {
    weatherProvider.client = MockClient((request) async {
      return Response(json.encode([0]), 200);
    });
  });
}
