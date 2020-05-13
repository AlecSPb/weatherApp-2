import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/data/scopes/weather_scope.dart';
import 'package:weatherapp/providers/global/config/config_provider.dart';
import 'package:weatherapp/providers/global/location/location_provider.dart';
import 'package:weatherapp/providers/global/preferences/preferences_provider.dart';
import 'package:weatherapp/providers/global/weather/weather_provider.dart';
import 'package:weatherapp/providers/home/home_provider.dart';
import 'package:weatherapp/widgets/currentWeatherCard.dart';
import 'package:weatherapp/widgets/forecastAccordion.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_homeProvider == null) {
      PreferencesProvider preferencesProvider =
          Provider.of<PreferencesProvider>(context);
      LocationProvider locationProvider =
          Provider.of<LocationProvider>(context);
      WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);
      ConfigProvider configProvider = Provider.of<ConfigProvider>(context);
      _homeProvider = HomeProvider(
        preferencesProvider: preferencesProvider,
        locationProvider: locationProvider,
        weatherProvider: weatherProvider,
        configProvider: configProvider,
      );
    }

    _homeProvider.initProvider(context);
  }

  @override
  void dispose() {
    super.dispose();
    _homeProvider.disposeProvider();
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherScope.of(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                // TODO the image URL should be defined in the app configs
                image: AssetImage("assets/images/home_page_background.jpeg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: SingleChildScrollView(
                child: Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  AppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () => _homeProvider.pushSettings(context),
                        color: Colors.white,
                      ),
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  StreamBuilder(
                    stream: weatherBloc.weatherDataLoaded,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Container(
                            height: 400.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Theme(
                                    data: Theme.of(context)
                                        .copyWith(accentColor: Colors.white),
                                    child: const CircularProgressIndicator(),
                                  ),
                                ]),
                          );
                        default:
                          return Column(
                            children: <Widget>[
                              CurrentWeatherCard(
                                  snapshot.data['currentWeather']),
                              ForecastAccordion(
                                  snapshot.data['weatherForecast'])
                            ],
                          );
                      }
                    },
                  ),
                ],
              ),
            )),
          ),
        ),
      ],
    ));
  }
}
