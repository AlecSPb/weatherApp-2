import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weatherapp/data/blocs/weather_bloc.dart';
import 'package:weatherapp/data/scopes/geolocation_scope.dart';

import 'package:weatherapp/data/scopes/weather_scope.dart';
import 'package:weatherapp/providers/global/config/config_provider.dart';
import 'package:weatherapp/providers/global/location/location_provider.dart';
import 'package:weatherapp/providers/global/preferences/preferences_provider.dart';
import 'package:weatherapp/providers/global/weather/weather_provider.dart';
import 'package:weatherapp/routes.dart';

class HomeProvider {
  Timer _timer;
  PreferencesProvider preferencesProvider;
  LocationProvider locationProvider;
  WeatherProvider weatherProvider;
  ConfigProvider configProvider;

  HomeProvider({
    this.preferencesProvider,
    this.locationProvider,
    this.weatherProvider,
    this.configProvider,
  });

  Future<void> initProvider(BuildContext context) async {
    final weatherBloc = WeatherScope.of(context);

    preferencesProvider.getUseGeolocation().then((bool useGeolocation) {
      // If geolocation is not enabled use city or zip
      if (useGeolocation == null || useGeolocation != true) {
        preferencesProvider.getCustomLocation().then((String name) {
          if (name == null || name.isEmpty) {
            // TODO default city should come from the settings
            _fetchWeatherDataByCity(weatherBloc, "Berlin");
          } else {
            _fetchWeatherDataByCity(weatherBloc, name);
          }
        });
      } else {
        final geolocationBloc = GeolocationScope.of(context);
        geolocationBloc.changeLocation(locationProvider.userLocation);
        locationProvider.updatePosition().then((_) {
          int lat = locationProvider.userLocation.latitude.toInt();
          int lon = locationProvider.userLocation.longitude.toInt();
          _fetchWeatherDataByCoords(weatherBloc, lat, lon);
        });
      }
    });
  }

  void disposeProvider() {
    _timer?.cancel();
  }

  void pushSettings(BuildContext context) async {
    await AppRoutes.push(context, "/settings");
  }

  void _fetchWeatherDataByCity(WeatherBloc weatherBloc, String name) {
    weatherProvider.fetchCurrentWeatherByCity(name).then((currentWeather) {
      weatherBloc.changeCurrentWeather(currentWeather);
      _timer = Timer.periodic(
        Duration(
            seconds: this
                .configProvider
                .appConfig
                .updateCurrentWeatherIntervalSeconds),
        (Timer t) {
          weatherProvider
              .fetchCurrentWeatherByCity(name)
              .then((currentWeather) {
            weatherBloc.changeCurrentWeather(currentWeather);
          });
        },
      );
    });

    weatherProvider.fetchWeatherForecastByCity(name).then((weatherDatasets) {
      weatherBloc.changeWeatherForecast(weatherDatasets);
    });
  }

  void _fetchWeatherDataByCoords(WeatherBloc weatherBloc, int lat, int lon) {
    weatherProvider
        .fetchCurrentWeatherByCoords(lat, lon)
        .then((currentWeather) {
      weatherBloc.changeCurrentWeather(currentWeather);
      _timer = Timer.periodic(
        Duration(
            seconds: this
                .configProvider
                .appConfig
                .updateCurrentWeatherIntervalSeconds),
        (Timer t) {
          weatherProvider
              .fetchCurrentWeatherByCoords(lat, lon)
              .then((currentWeather) {
            weatherBloc.changeCurrentWeather(currentWeather);
          });
        },
      );
    });

    weatherProvider
        .fetchWeatherForecastByCoords(lat, lon)
        .then((weatherDatasets) {
      weatherBloc.changeWeatherForecast(weatherDatasets);
    });
  }
}
