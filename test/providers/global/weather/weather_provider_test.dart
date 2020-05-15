import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weatherapp/models/weatherDataset.dart';
import 'package:weatherapp/providers/global/weather/weather_provider.dart';

// Mock data
final dynamic currentWeather = {
  "coord": {"lon": 139, "lat": 35},
  "weather": [
    {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01n"}
  ],
  "base": "stations",
  "main": {
    "temp": 281.52,
    "feels_like": 278.99,
    "temp_min": 280.15,
    "temp_max": 283.71,
    "pressure": 1016,
    "humidity": 93
  },
  "wind": {"speed": 0.47, "deg": 107.538},
  "clouds": {"all": 2},
  "dt": 1560350192,
  "sys": {
    "type": 3,
    "id": 2019346,
    "message": 0.0065,
    "country": "JP",
    "sunrise": 1560281377,
    "sunset": 1560333478
  },
  "timezone": 32400,
  "id": 1851632,
  "name": "Shuzenji",
  "cod": 200
};

final dynamic fiveDayForecast = {
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1578409200,
      "main": {
        "temp": 284.92,
        "feels_like": 281.38,
        "temp_min": 283.58,
        "temp_max": 284.92,
        "pressure": 1020,
        "sea_level": 1020,
        "grnd_level": 1016,
        "humidity": 90,
        "temp_kf": 1.34
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": {"all": 100},
      "wind": {"speed": 5.19, "deg": 211},
      "sys": {"pod": "d"},
      "dt_txt": "2020-01-07 15:00:00"
    },
  ],
  "city": {
    "id": 2643743,
    "name": "London",
    "coord": {"lat": 51.5073, "lon": -0.1277},
    "country": "GB",
    "timezone": 0,
    "sunrise": 1578384285,
    "sunset": 1578413272
  }
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final WeatherProvider weatherProvider = WeatherProvider(
    openWeatherApiKey: "0",
    openWeatherEndpoint: "https://api.openweathermap.org/data/2.5/",
    temperatureUnits: "metric",
  );

  // Mock client
  weatherProvider.client = MockClient((Request request) async {
    String urlBeginning = request.url.toString().split("?")[0];
    String targetEndpoint = urlBeginning.split("/").last;

    switch (targetEndpoint) {
      case "weather":
        return Response(json.encode(currentWeather), 200);
        break;
      case "forecast":
        return Response(json.encode(fiveDayForecast), 200);
        break;
      default:
        return Response(null, 404);
    }
  });

  group("WeatherProvider", () {
    test("fetchCurrentWeatherByCity returns a WeatherDataset model.", () async {
      final WeatherDataset currentWeatherDataset =
          await weatherProvider.fetchCurrentWeatherByCity("Stuttgart");

      expect(currentWeatherDataset.temp, 281.52);
    });

    test("fetchCurrentWeatherByCoords returns a WeatherDataset model.",
        () async {
      final WeatherDataset currentWeatherDataset =
          await weatherProvider.fetchCurrentWeatherByCoords(0, 0);

      expect(currentWeatherDataset.temp, 281.52);
    });

    test("fetchWeatherForecastByCity returns a list of WeatherDataset.",
        () async {
      final List<WeatherDataset> forecastDatasets =
          await weatherProvider.fetchWeatherForecastByCity("Stuttgart");

      expect(forecastDatasets.first.temp, 284.92);
    });

    test("fetchWeatherForecastByCoords returns a list of WeatherDataset.",
        () async {
      final List<WeatherDataset> forecastDatasets =
          await weatherProvider.fetchWeatherForecastByCoords(0, 0);

      expect(forecastDatasets.first.temp, 284.92);
    });
  });
}
