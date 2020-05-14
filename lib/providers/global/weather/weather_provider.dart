import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;

import 'package:weatherapp/models/weatherDataset.dart';

class WeatherProvider {
  Client client = Client();
  final String openWeatherEndpoint;
  final String openWeatherApiKey;
  final String temperatureUnits;

  WeatherProvider({
    @required this.openWeatherApiKey,
    @required this.openWeatherEndpoint,
    @required this.temperatureUnits,
  });

  Future<WeatherDataset> fetchCurrentWeatherByCity(String cityName) async {
    final response = await client.get(
        "$openWeatherEndpoint/weather?q=$cityName&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      return WeatherDataset.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data.");
    }
  }

  Future<WeatherDataset> fetchCurrentWeatherByCoords(int lat, int lon) async {
    final response = await client.get(
        "$openWeatherEndpoint/weather?lat=$lat&lon=$lon&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      return WeatherDataset.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data.");
    }
  }

  Future<List<WeatherDataset>> fetchWeatherForecastByCoords(
      int lat, int lon) async {
    final response = await client.get(
        "$openWeatherEndpoint/forecast?lat=$lat&lon=$lon&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      return _getWeatherDatasetList(response.body);
    } else {
      throw Exception("Failed to load weather data.");
    }
  }

  Future<List<WeatherDataset>> fetchWeatherForecastByCity(
      String cityName) async {
    final response = await client.get(
        "$openWeatherEndpoint/forecast?q=$cityName&appid=$openWeatherApiKey&units=metric");

    if (response.statusCode == 200) {
      return _getWeatherDatasetList(response.body);
    } else {
      throw Exception("Failed to load weather data.");
    }
  }

  List<WeatherDataset> _getWeatherDatasetList(String responseBody) {
    dynamic decodedBody = json.decode(responseBody);
    return (decodedBody["list"] as List).map((dataset) {
      WeatherDataset weatherDataset = WeatherDataset.fromJson(dataset);
      weatherDataset.name = decodedBody["city"]["name"];
      weatherDataset.lon = decodedBody["city"]["coord"]["lon"];
      weatherDataset.lat = decodedBody["city"]["coord"]["lat"];
      return weatherDataset;
    }).toList();
  }
}
