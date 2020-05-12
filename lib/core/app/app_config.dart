abstract class AppConfig {
  String appName;
  String openWeatherEndpoint;
  String openWeatherApiKey;
  String openWeatherImageUrl;
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
}
