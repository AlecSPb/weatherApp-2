import 'dart:async';
import "package:collection/collection.dart";

import 'package:weatherapp/models/dailyForecast.dart';
import 'package:weatherapp/models/weatherDataset.dart';

class DailyForecastListTransformer {
  final dailyForecastListTransformer =
      StreamTransformer<List<WeatherDataset>, List<DailyForecast>>.fromHandlers(
    handleData: (weatherDatasets, sink) {
      List<DailyForecast> dailyForecasts = List<DailyForecast>();

      // Group our five day 3-hour forecast by the weekday
      Map<dynamic, List<WeatherDataset>> groupedByWeekday = groupBy(
        weatherDatasets,
        (WeatherDataset dataset) => dataset.dateTime.weekday,
      );

      // With each of this groups build a DailyForecast object
      groupedByWeekday.forEach((dynamic key, List<WeatherDataset> value) {
        double tempMin;
        double tempMax;
        List<WeatherDataset> dailyForecastDatasets = List<WeatherDataset>();

        for (WeatherDataset dataset in value) {
          // Determine min and max temperature for each day
          if (tempMin == null || dataset.tempMin < tempMin)
            tempMin = dataset.tempMin;
          if (tempMax == null || dataset.tempMax > tempMax)
            tempMax = dataset.tempMax;

          dailyForecastDatasets.add(dataset);
        }

        DailyForecast dailyForecast = DailyForecast(
          tempMin: tempMin,
          tempMax: tempMax,
          datasets: dailyForecastDatasets,
        );

        dailyForecasts.add(dailyForecast);
      });

      sink.add(dailyForecasts);
    },
  );
}
