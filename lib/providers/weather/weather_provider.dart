import 'dart:convert';

import 'package:http/http.dart' show get;

import 'package:weatherapp/models/weatherDataset.dart';

class WeatherProvider {
  final String openWeatherEndpoint;
  final String openWeatherApiKey;

  WeatherProvider({this.openWeatherApiKey, this.openWeatherEndpoint});

  Future<WeatherDataset> fetchCurrentWeather(String cityName) async {
    final response = await get(
        "$openWeatherEndpoint/weather?q=$cityName&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      return WeatherDataset.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data.");
    }
  }

  Future<List<WeatherDataset>> fetchWeatherForecast(String cityName) async {
    final response = await get(
        "$openWeatherEndpoint/forecast?q=$cityName&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);
      return (decodedBody["list"] as List).map((dataset) {
        WeatherDataset weatherDataset = WeatherDataset.fromJson(dataset);
        weatherDataset.name = decodedBody["city"]["name"];
        weatherDataset.lon = decodedBody["city"]["coord"]["lon"];
        weatherDataset.lat = decodedBody["city"]["coord"]["lat"];
        return weatherDataset;
      }).toList();
    } else {
      throw Exception("Failed to load weather data.");
    }
  }
}
