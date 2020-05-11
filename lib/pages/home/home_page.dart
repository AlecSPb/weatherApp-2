import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/data/injectors/weather_injector.dart';
import 'package:weatherapp/providers/weather/weather_provider.dart';
import 'package:weatherapp/routes.dart';
import 'package:weatherapp/widgets/currentWeatherCard.dart';
import 'package:weatherapp/widgets/forecastAccordion.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    // This Future is used to access the context
    Future.delayed(Duration.zero, () {
      final weatherBloc = WeatherInjector.of(context);
      WeatherProvider weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);

      // TODO: the city name should be loaded from the shared preferences
      weatherProvider.fetchCurrentWeather("Stuttgart").then((currentWeather) {
        weatherBloc.changeCurrentWeather(currentWeather);
      });

      _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        weatherProvider.fetchCurrentWeather("Stuttgart").then((currentWeather) {
          weatherBloc.changeCurrentWeather(currentWeather);
        });
      });

      // TODO: the city name should be loaded from the shared preferences
      weatherProvider.fetchWeatherForecast("Stuttgart").then((forecast) {
        print(forecast[0].name);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home_page_background.jpeg"),
                fit: BoxFit.cover),
          ),
        ),
        new Container(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: SingleChildScrollView(
                child: new Container(
              color: Colors.transparent,
              child: new Column(
                children: <Widget>[
                  AppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: _pushSettings,
                        color: Colors.white,
                      ),
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  CurrentWeatherCard(),
                  ForecastAccordion()
                ],
              ),
            )),
          ),
        ),
      ],
    ));
  }

  void _pushSettings() {
    AppRoutes.push(context, "/settings");
  }
}
