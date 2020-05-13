import 'package:flutter/material.dart';
import 'package:weatherapp/data/blocs/geolocation_bloc.dart';

class GeolocationScope extends InheritedWidget {
  final geolocationBloc = GeolocationBloc();

  GeolocationScope({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static GeolocationBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<GeolocationScope>())
        .geolocationBloc;
  }
}
