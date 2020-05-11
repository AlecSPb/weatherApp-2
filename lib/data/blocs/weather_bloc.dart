import 'dart:async';

import 'package:weatherapp/data/transformers/dailyForecast_transformer.dart';
import 'package:weatherapp/models/dailyForecast.dart';
import 'package:weatherapp/models/weatherDataset.dart';

class WeatherBloc with DailyForecastTransformer {
  final _currentWeatherController = StreamController<WeatherDataset>();
  final _weatherForecastController = StreamController<List<WeatherDataset>>();

  // For accessing data in a StreamBuilder
  Stream<WeatherDataset> get currentWeather => _currentWeatherController.stream;
  Stream<List<DailyForecast>> get weatherForecast =>
      _weatherForecastController.stream.transform(dailyForecastTransformer);

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
