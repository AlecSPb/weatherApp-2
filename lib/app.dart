import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/core/app/app_config.dart';
import 'package:weatherapp/data/scopes/geolocation_scope.dart';
import 'package:weatherapp/data/scopes/weather_scope.dart';
import 'package:weatherapp/pages/home/home_page.dart';
import 'package:weatherapp/pages/settings/settings_page.dart';
import 'package:weatherapp/providers/global/config/config_provider.dart';
import 'package:weatherapp/providers/global/location/location_provider.dart';
import 'package:weatherapp/providers/global/preferences/preferences_provider.dart';
import 'package:weatherapp/providers/global/weather/weather_provider.dart';
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
        Provider(create: (context) => ConfigProvider(appConfig)),
        Provider(create: (context) => PreferencesProvider()),
        Provider(
          create: (context) => WeatherProvider(
              openWeatherApiKey: appConfig.openWeatherApiKey,
              openWeatherEndpoint: appConfig.openWeatherEndpoint),
        ),
        Provider(
          create: (context) => LocationProvider(),
        ),
      ],
      child: WeatherScope(
          child: GeolocationScope(
        child: MaterialApp(
          title: 'Welcome to Flutter - Weather App',
          initialRoute: AppRoutes.home,
          routes: <String, WidgetBuilder>{
            AppRoutes.home: (BuildContext context) => new HomePage(),
            AppRoutes.settings: (BuildContext context) => new SettingsPage()
          },
        ),
      )),
    );
  }
}
