class WeatherDataset {
  String icon;
  double lon;
  double lat;
  String name;
  double temp;
  double tempMin;
  double tempMax;
  DateTime dateTime;

  WeatherDataset({
    this.icon,
    this.lon,
    this.lat,
    this.name,
    this.temp,
    this.tempMin,
    this.tempMax,
    this.dateTime,
  });

  factory WeatherDataset.fromJson(Map<String, dynamic> json) {
    return WeatherDataset(
      icon: json['weather'][0]['icon'],
      lon: json['lon']?.toDouble(),
      lat: json['lat']?.toDouble(),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json["dt"].toInt() * 1000),
    );
  }
}
