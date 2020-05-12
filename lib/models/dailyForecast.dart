import 'package:weatherapp/models/weatherDataset.dart';

class DailyForecast {
  double tempMin;
  double tempMax;
  List<WeatherDataset> datasets;

  DailyForecast({
    this.tempMin,
    this.tempMax,
    this.datasets,
  });
}
