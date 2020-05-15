class WeatherDataset {
  String description;
  String icon;
  double lon;
  double lat;
  String name;
  double temp;
  double tempMin;
  double tempMax;
  DateTime dateTime;

  WeatherDataset({
    this.description,
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
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      lon: json['coord'] != null ? json['coord']['lon'].toDouble() : null,
      lat: json['coord'] != null ? json['coord']['lat'].toDouble() : null,
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json["dt"].toInt() * 1000),
    );
  }
}
