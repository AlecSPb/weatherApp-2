abstract class AppConfig {
  String appName;
  String openWeatherEndpoint;
  String openWeatherApiKey;
  String openWeatherImageUrl;
  int updateCurrentWeatherIntervalSeconds;
  int updateDailyForecastIntervalSeconds;
}

class DevConfig implements AppConfig {
  @override
  String appName = "Weater App - Development";

  @override
  String openWeatherEndpoint = "https://api.openweathermap.org/data/2.5";

  @override
  String openWeatherApiKey = "662c3ceb4273ab998624e819fbdcd93f";

  @override
  String openWeatherImageUrl = "https://openweathermap.org/img/wn";

  @override
  int updateCurrentWeatherIntervalSeconds = 5;

  @override
  int updateDailyForecastIntervalSeconds = 30;
}

class StageConfig implements AppConfig {
  @override
  String appName = "Weater App - Staging";

  @override
  String openWeatherEndpoint = "https://api.openweathermap.org/data/2.5";

  @override
  String openWeatherApiKey = "662c3ceb4273ab998624e819fbdcd93f";

  @override
  String openWeatherImageUrl = "https://openweathermap.org/img/wn";

  @override
  int updateCurrentWeatherIntervalSeconds = 5;

  @override
  int updateDailyForecastIntervalSeconds = 30;
}

class ProdConfig implements AppConfig {
  @override
  String appName = "Weater App - Production";

  @override
  String openWeatherEndpoint = "https://api.openweathermap.org/data/2.5";

  @override
  String openWeatherApiKey = "662c3ceb4273ab998624e819fbdcd93f";

  @override
  String openWeatherImageUrl = "https://openweathermap.org/img/wn";

  @override
  int updateCurrentWeatherIntervalSeconds = 5;

  @override
  int updateDailyForecastIntervalSeconds = 30;
}
