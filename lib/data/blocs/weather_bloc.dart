import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:weatherapp/data/transformers/dailyForecastList_transformer.dart';
import 'package:weatherapp/models/dailyForecast.dart';
import 'package:weatherapp/models/weatherDataset.dart';

class WeatherBloc with DailyForecastListTransformer {
  final _currentWeatherController = BehaviorSubject<WeatherDataset>();
  final _weatherForecastController = BehaviorSubject<List<WeatherDataset>>();

  // For accessing data in a StreamBuilder
  Stream<WeatherDataset> get currentWeather => _currentWeatherController.stream;
  Stream<List<DailyForecast>> get weatherForecast =>
      _weatherForecastController.stream.transform(dailyForecastListTransformer);
  Stream<Map<String, dynamic>> get weatherDataLoaded =>
      Rx.combineLatest2(currentWeather, weatherForecast,
          (currentWeather, weatherForecast) {
        return {
          'currentWeather': currentWeather,
          'weatherForecast': weatherForecast
        };
      });

  // Change data
  Function(WeatherDataset) get changeCurrentWeather =>
      _currentWeatherController.sink.add;
  Function(List<WeatherDataset>) get changeWeatherForecast =>
      _weatherForecastController.sink.add;

  dispose() {
    _currentWeatherController.close();
    _weatherForecastController.close();
  }
}
