import 'dart:async';
import 'package:weatherapp/models/dailyForecast.dart';
import 'package:weatherapp/models/weatherDataset.dart';

class DailyForecastTransformer {
  final dailyForecastTransformer =
      StreamTransformer<List<WeatherDataset>, List<DailyForecast>>.fromHandlers(
          handleData: (weatherDatasets, sink) {
    double tempMin;
    double tempMax;
    List<DailyForecast> dailyForecasts = List<DailyForecast>();
    for (var dataset in weatherDatasets) {
      if (tempMin == null || dataset.tempMin < tempMin)
        tempMin = dataset.tempMin;
      if (tempMax == null || dataset.tempMax > tempMax)
        tempMax = dataset.tempMax;
    }

    sink.add(dailyForecasts);
  });
}
