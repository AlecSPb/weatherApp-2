import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/core/app/app_config.dart';
import 'package:weatherapp/data/injectors/weather_injector.dart';
import 'package:weatherapp/pages/home/home_page.dart';
import 'package:weatherapp/pages/settings/settings_page.dart';
import 'package:weatherapp/providers/preferences/preferences_provider.dart';
import 'package:weatherapp/providers/weather/weather_provider.dart';
import 'package:weatherapp/routes.dart';

class WeatherApp extends StatefulWidget {
  final AppConfig appConfig;

  WeatherApp({this.appConfig});

  @override
  State<StatefulWidget> createState() => _WeatherAppState(appConfig: appConfig);
}

class _WeatherAppState extends State<WeatherApp> {
  final AppConfig appConfig;
  PreferencesProvider preferencesProvider;

  _WeatherAppState({this.appConfig});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => PreferencesProvider()),
        Provider(
          create: (context) => WeatherProvider(
              openWeatherApiKey: appConfig.openWeatherApiKey,
              openWeatherEndpoint: appConfig.openWeatherEndpoint),
        ),
      ],
      child: WeatherInjector(
        child: MaterialApp(
          title: 'Welcome to Flutter - Weather App',
          initialRoute: AppRoutes.home,
          routes: <String, WidgetBuilder>{
            AppRoutes.home: (BuildContext context) => new HomePage(),
            AppRoutes.settings: (BuildContext context) => new SettingsPage()
          },
        ),
      ),
    );
  }
}
