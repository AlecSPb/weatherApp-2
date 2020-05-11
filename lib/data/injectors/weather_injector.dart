import 'package:flutter/material.dart';
import 'package:weatherapp/data/blocs/weather_bloc.dart';

class WeatherInjector extends InheritedWidget {
  final weatherBloc = WeatherBloc();

  WeatherInjector({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WeatherBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<WeatherInjector>())
        .weatherBloc;
  }
}
